unit uJPEGCompressor;

interface

uses
  Vcl.Imaging.JPEG, VCL.Graphics, System.Classes, System.SysUtils, System.IOUtils, 
  DateUtils, Img32, Img32.Fmt.JPG, uConstants, CCR.Exif;

type
  TResampleMode = (rmNone=0, rmFastest=1, rmRecommended=2, rmBest=3);
  TRotateAmount = (raNone=0, ra90=1, ra180=2, ra270=3);
  TJPEGCompressor = class(TObject)
  strict private
    fCreateThumbnail: boolean;
    fResampleMode: TResampleMode;
    fRotateAmount: TRotateAmount;
    fOriginalFilesize,
    fCompressedFilesize: uInt64;
    fSourceFilename: string;
    fOutputDir: string;
    fApplyGraphics,
    fCompress: boolean;
    fShrinkByHeight: boolean;
    fShrinkByMaxPx: integer;
    fCompressionQuality: integer;
    fTargetKB: integer;
    fJPEG,
    fJPEGOriginal: TJPEGImage;
    fBitmap: TBitmap;
    fMessages: TStringList;
    fStartTime,
    fEndTime: TDateTime;
    fMemoryStream,
    fMemoryStreamOrig: TMemoryStream;
    fAlreadyCompressed: boolean;
    fImageWidth,
    fImageHeight,
    fMinQuality: integer;
    fReplaceOriginal: boolean;
    fThumbnailFilename,
    fOutputFilename: string;
    fShrinkByBoth: boolean;
    fThumbnailSizePx: integer;
    function SaveOriginalToOutput: string;
    function DoCreateThumbnail: boolean;
    procedure CompressJPG(const AJPEG: TJPEGImage; const ACompressionQuality: integer);
    function SizeOfJPEG(const AJPEG: TJPEGImage): Int64;
    procedure TryCompression(const AQuality: integer=cMinQuality);
    procedure SetOutputDir(const Value: string);
    procedure RetryWithReducedScale;
    procedure ShrinkAndRotate;
    function SaveToDisk: boolean;
    function SaveToStream: boolean;
    procedure CompressToTarget;
    //procedure HandleExifOrientation;
  public
    constructor Create;
    destructor Destroy; override;
    function Process(const AFilename: string=''; const ASaveToDisk: boolean=true): boolean;
    property SourceFilename: string read fSourceFilename;
    property OutputDir: string read fOutputDir write SetOutputDir;
    property ApplyGraphics: boolean read fApplyGraphics write fApplyGraphics;
    property Compress: boolean read fCompress write fCompress;
    property ShrinkByHeight: boolean read fShrinkByHeight write fShrinkByHeight;
    property ShrinkByMaxPx: integer read fShrinkByMaxPx write fShrinkByMaxPx;
    property CompressionQuality: integer read fCompressionQuality write fCompressionQuality;
    property TargetKB: integer read fTargetKB write fTargetKB;
    property OriginalFilesize: uInt64 read fOriginalFilesize;
    property CompressedFilesize: uInt64 read fCompressedFilesize;
    property Messages: TStringList read fMessages;
    property JPEG: TJPEGImage read fJPEG;
    property Bitmap: TBitmap read fBitmap;
    property MemoryStream: TMemoryStream read fMemoryStream;
    property MemoryStreamOrig: TMemoryStream read fMemoryStreamOrig;
    property ImageWidth: integer read fImageWidth write fImageWidth;
    property ImageHeight: integer read fImageHeight write fImageHeight;
    property RotateAmount: TRotateAmount read fRotateAmount write fRotateAmount;
    property ResampleMode: TResampleMode read fResampleMode write fResampleMode;
    property JPEGOriginal: TJPEGImage read fJPEGOriginal write fJPEGOriginal;
    property ReplaceOriginal: boolean read fReplaceOriginal write fReplaceOriginal;
    property CreateThumbnail: boolean read fCreateThumbnail write fCreateThumbnail;
    property ThumbnailFilename: string read fThumbnailFilename write fThumbnailFilename;
    property OutputFilename: string read fOutputFilename write fOutputFilename;
    property ShrinkByBoth: boolean read fShrinkByBoth write fShrinkByBoth;
    property ThumbnailSizePx: integer read fThumbnailSizePx write fThumbnailSizePx;
  end;

implementation

{ TJPEGCompressor }

constructor TJPEGCompressor.Create;
begin
  inherited;
  fThumbnailSizePx := cDefaultThumbnailMaxSizePx;
  fShrinkByBoth := false;
  fOutputFilename := '';
  fThumbnailFilename := '';
  fCreateThumbnail := false;
  fReplaceOriginal := false;
  fCompress := true;
  fCompressionQuality := cMaxQuality;
  fTargetKB := 0;
  fShrinkByHeight := false;
  fShrinkByMaxPx := cDefaultMaxWidth;
  fApplyGraphics := false;
  fBitmap := TBitmap.Create;
  fJPEG := TJPEGImage.Create;
  fJPEGOriginal := TJPEGImage.Create;
  fJPEG.ProgressiveDisplay := false;
  fJPEGOriginal.ProgressiveDisplay := false;
  fMessages := TStringList.Create;
  fAlreadyCompressed := false;
  fResampleMode := rmRecommended;
  fRotateAmount := raNone;
  fMemoryStream := TMemoryStream.Create;
  fMemoryStreamOrig := TMemoryStream.Create;
  fMinQuality := cMinQuality;
end;

destructor TJPEGCompressor.Destroy;
begin
  try
    fBitmap.Free;
    fJPEG.Free;
    fJPEGOriginal.Free;
    fMessages.Free;
    fMemoryStreamOrig.Free;
    fMemoryStream.Free;
  finally
    inherited;
  end;
end;

function TJPEGCompressor.DoCreateThumbnail: boolean;
var
  compressor: TJPEGCompressor;
  thumbnailPath: string;
begin
  if fCreateThumbnail then
  begin
    // Create unique thumbnail filename based on source file
    thumbnailPath := ChangeFileExt(fSourceFilename, '') + cThumbnailSuffix + ExtractFileExt(fSourceFilename);
    fThumbnailFilename := TPath.Combine(fOutputDir, ExtractFileName(thumbnailPath));
    WriteLn('Debug: Creating thumbnail at ' + fThumbnailFilename);
  end;
  
  result := fCreateThumbnail and FileExists(fSourceFilename);
  if result then 
  begin
    compressor := TJPEGCompressor.Create;
    try
      compressor.Compress := false;
      compressor.ApplyGraphics := true;
      compressor.ShrinkByMaxPx := fThumbnailSizePx;
      compressor.ShrinkByBoth := true;
      compressor.OutputDir := fOutputDir;
      compressor.OutputFilename := fThumbnailFilename;
      result := compressor.Process(fSourceFilename);
      if not result then
        WriteLn('Debug: Failed to create thumbnail');
    finally
      compressor.Free;
    end;
  end;
end;

function TJPEGCompressor.Process(const AFilename: string=''; const ASaveToDisk: boolean=true): boolean;
begin
  try
    fMessages.Clear;
    fStartTime := Now;
    WriteLn('Debug: Processing file ' + AFilename);
    WriteLn('Debug: Output dir is ' + fOutputDir);
    fOriginalFilesize := 0;
    fCompressedFilesize := 0;
    fImageWidth := 0;
    fImageHeight := 0;
    result := FileExists(AFilename);
    if result then begin
      fMemoryStream.Clear;
      fJPEGOriginal.Scale := jsFullsize;
      fJPEG.Scale := jsFullsize;
      if fSourceFilename <> AFilename then begin
        fMemoryStreamOrig.Clear;
        fSourceFilename := AFilename;
        fJPEG.LoadFromFile(fSourceFilename);
        fJPEG.SaveToStream(fMemoryStreamOrig);
        fMemoryStreamOrig.Position := 0;
        fJPEGOriginal.LoadFromStream(fMemoryStreamOrig);
      end else begin
        fMemoryStreamOrig.Position := 0;
        fJPEG.LoadFromStream(fMemoryStreamOrig);
      end;
      fOriginalFilesize := Round(fMemoryStreamOrig.Size / cBytesToKB);
      ShrinkAndRotate;
      if fCompress then begin
        if fTargetKB > 0 then begin
          if fTargetKB < fOriginalFilesize then
            CompressToTarget
          else
            fJPEG.CompressionQuality := 100;
        end else
          TryCompression(fCompressionQuality);
      end else if fAlreadyCompressed then begin
        CompressJPG(fJPEG, cMaxQuality);
        fAlreadyCompressed := false;
      end;
      fImageWidth := fJPEG.Width;
      fImageHeight := fJPEG.Height;
      fCompressedFilesize := Round(SizeOfJPEG(fJPEG) / cBytesToKB);
      fEndTime := Now;
      if ASaveToDisk then begin
        if fCompressedFilesize >= fOriginalFilesize then begin
          result := false;
          WriteLn('Debug: Saving uncompressed because compressed size is larger');
          fMessages.Add('JPEG saved to (uncompressed): '+SaveOriginalToOutput);
        end else begin
          WriteLn('Debug: About to save compressed file');
          result := SaveToDisk;
          if result then
            WriteLn('Debug: Successfully saved to ' + fOutputFilename)
          else
            WriteLn('Debug: Failed to save to ' + fOutputFilename);
          fMessages.Add('Processed '+ExtractFileName(fSourceFilename)+' in '+SecondsBetween(fStartTime, fEndTime).ToString+'ms');
          fMessages.Add('Uncompressed file size (KB): '+fOriginalFilesize.ToString);
          fMessages.Add('Compressed file size (KB): '+fCompressedFilesize.ToString);
          fMessages.Add('JPEG saved to: '+fOutputFilename);
        end;
        if fCreateThumbnail then begin
          WriteLn('Debug: Creating thumbnail');
          if DoCreateThumbnail then
            WriteLn('Debug: Created thumbnail at ' + fThumbnailFilename)
          else
            WriteLn('Debug: Failed to create thumbnail');
        end;
      end else
        SaveToStream;
    end else
      fMessages.Add(fSourceFilename+' not found');
  except
    on e: Exception do begin
      result := false;
      WriteLn('Debug: Exception - ' + e.Message);
      fMessages.Add('Error processing '+ExtractFileName(SourceFilename)+e.Classname+' '+e.Message);
    end;
  end;
end;

procedure TJPEGCompressor.RetryWithReducedScale;
var
  scale: TJPEGScale;
begin
  scale := fJPEG.Scale;
  while (fCompressedFilesize > fTargetKB) and
        (scale <= TJPEGScale.jsQuarter) do begin
    fMemoryStreamOrig.Position := 0;
    fJPEG.LoadFromStream(fMemoryStreamOrig);
    scale := TJPEGScale(integer(scale) + 1);
    fJPEG.Scale := scale;
    fCompressionQuality := 90;
    fJPEG.CompressionQuality := 90;
    TryCompression(cMaxQuality-cTargetInterval);
  end;
end;

procedure TJPEGCompressor.CompressJPG(const AJPEG: TJPEGImage; const ACompressionQuality: integer);
begin
  if (ACompressionQuality < 100) and
     (ACompressionQuality >= cMinQuality) and
     (ACompressionQuality <= cMaxQuality) then begin
    try
      fAlreadyCompressed := true;
      fJPEG.CompressionQuality := ACompressionQuality;
      fJPEG.Compress;
    finally
      fCompressedFilesize := Round(SizeOfJPEG(fJPEG) / cBytesToKB);
    end;
  end;
end;

procedure TJPEGCompressor.CompressToTarget;
begin
  if (fCompressedFilesize = 0) or
     (fCompressedFilesize > fTargetKB) then begin
    fJPEG.Scale := jsFullsize;
    if ((SizeOfJPEG(fJPEG) / 3) / cBytesToKB) >= fTargetKB then //~1/3 reduction for ~50 quality, preemptively downscale for performance
      fJPEG.Scale := jsHalf;
    fMinQuality := cScaleBelowQuality; //retry with reduced scale below this quality level
    try
      TryCompression(cMaxQuality-cTargetInterval);
      if fCompressedFilesize > fTargetKB then
        RetryWithReducedScale;
    finally
      fMinQuality := cMinQuality;
    end;
  end;
end;

procedure TJPEGCompressor.ShrinkAndRotate;
var
  reducePC: double;
  size: integer;
  img32: TImage32;
  ms: TMemoryStream;
  shrinked: boolean;
begin
  if fShrinkByHeight then
    size := fJPEG.Height
  else
    size := fJPEG.Width;
  if fApplyGraphics then begin
    ms := TMemoryStream.Create;
    img32 := TImage32.Create;
    shrinked := false;
    try
      if fShrinkByBoth then begin
        if fJPEG.Height >= fJPEG.Width then
          reducePC := fShrinkByMaxPx / fJPEG.Height
        else
          reducePC := fShrinkByMaxPx / fJPEG.Width;
      end else if fShrinkByHeight then
        reducePC := fShrinkByMaxPx / fJPEG.Height
      else
        reducePC := fShrinkByMaxPx / fJPEG.Width;
      case fResampleMode of
        rmNone: begin
          if (fShrinkByMaxPx > 0) and
             (fShrinkByMaxPx < size) then begin
            fBitmap.Height := Round(fJPEG.Height * reducePC);
            fBitmap.Width := Round(fJPEG.Width * reducePC);
            fBitmap.Canvas.StretchDraw(Rect(0, 0, fBitmap.Width, fBitmap.Height), fJPEG);
            fJPEG.Assign(fBitmap);
            fCompressedFilesize := Round(SizeOfJPEG(fJPEG) / cBytesToKB);
            shrinked := true;
          end;
        end;
        rmFastest: img32.Resampler := rNearestResampler;
        rmRecommended: img32.Resampler := rBilinearResampler;
        rmBest: img32.Resampler := rBicubicResampler;
      end;
      SaveToStream;
      if ((not shrinked) and (fShrinkByMaxPx > 0)) or
         ((fRotateAmount <> raNone)) then begin
        img32.LoadFromStream(fMemoryStream);
        if (fApplyGraphics) and
           (not shrinked) and
           ((fShrinkByMaxPx > 0) and
            (fShrinkByMaxPx < size)) then
          img32.Resize(Round(fJPEG.Width * reducePC), Round(fJPEG.Height * reducePC));
        case fRotateAmount of
          ra90: img32.Rotate(angle90);
          ra180: img32.Rotate(angle180);
          ra270: img32.Rotate(angle270);
        end;
        img32.SaveToStream(ms, 'jpg');
        ms.Position := 0;
        fJPEG.LoadFromStream(ms);
        fCompressedFilesize := Round(ms.size / cBytesToKB);
      end;
    finally
      img32.Free;
      ms.Free;
    end;
  end;
end;

function TJPEGCompressor.SizeOfJPEG(const AJPEG: TJPEGImage): Int64;
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    AJPEG.SaveToStream(ms);
    result := ms.Size;
  finally
    ms.Free;
  end;
end;

procedure TJPEGCompressor.TryCompression(const AQuality: integer=cMinQuality);
begin
  if (AQuality >= fMinQuality) and
     (AQuality < cMaxQuality) then begin
    CompressJPG(fJPEG, AQuality);
    if (fTargetKB > 0) and
       ((fCompressedFilesize = 0) or (fCompressedFilesize > fTargetKB)) then
        TryCompression(AQuality-cTargetInterval);
  end;
end;

function TJPEGCompressor.SaveOriginalToOutput: string;
begin
  if fReplaceOriginal then
    result := fSourceFilename
  else begin
    result := fOutputDir + ExtractFileName(fSourceFilename);
    if result <> fSourceFilename then begin //dont replace the original with the original
      fJPEG.LoadFromFile(fSourceFilename); //save original to the output directory
      if FileExists(result) then
        DeleteFile(result);
      ForceDirectories(ExtractFilePath(result));
      fJPEG.SaveToFile(result);
      if not FileExists(result) then
        result := '';
    end;
  end;
end;

function TJPEGCompressor.SaveToDisk: boolean;
var 
  ExifData: TExifData;
  TargetFile: string;
begin
  try
    if fReplaceOriginal then
      TargetFile := fSourceFilename
    else begin
      if fOutputFilename = '' then
        fOutputFilename := TPath.Combine(fOutputDir, ExtractFileName(fSourceFilename));
      TargetFile := fOutputFilename;
      ForceDirectories(ExtractFilePath(TargetFile));
    end;

    if FileExists(TargetFile) then
      DeleteFile(TargetFile);

    fJPEG.SaveToFile(TargetFile);

    // Apply EXIF from original
    ExifData := TExifData.Create;
    try
      // Get EXIF from original image
      ExifData.LoadFromGraphic(fJPEGOriginal);
      // Save with original EXIF to JPEG object
      ExifData.SaveToGraphic(TJPEGImage(fJPEG));
      // Save JPEG to disk
      fJPEG.SaveToFile(TargetFile);
    finally
      ExifData.Free;
    end;
    
    result := FileExists(TargetFile);
  except
    on e: exception do begin
      result := false;
      fMessages.Add('Error saving JPEG to ' + fOutputFilename + ': ' + e.Message);
    end;
  end;
end;

function TJPEGCompressor.SaveToStream: boolean;
begin
  result := true;
  try
    fMemoryStream.Clear;
    fJPEG.SaveToStream(fMemoryStream);
    fMemoryStream.Position := 0;
  except
    on e: exception do begin
      result := false;
      fMessages.Add(e.Classname+' '+e.Message);
    end;
  end;
end;

procedure TJPEGCompressor.SetOutputDir(const Value: string);
begin
  fOutputDir := Value;
  fOutputDir := IncludeTrailingPathDelimiter(fOutputDir);
end;

end.