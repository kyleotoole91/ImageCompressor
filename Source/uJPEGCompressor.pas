unit uJPEGCompressor;

interface

uses
  Vcl.Imaging.JPEG, VCL.Graphics, System.Classes, System.SysUtils, DateUtils, Img32, Img32.Fmt.JPG, uConstants;

type
  TResampleMode = (rmNone=0, rmFastest=1, rmRecommended=2, rmBest=3);
  TRotateAmount = (raNone=0, ra90=1, ra180=2, ra270=3);
  TJPEGCompressor = class(TObject)
  private
    fResampleMode: TResampleMode;
    fRotateAmount: TRotateAmount;
    fOriginalFilesize,
    fCompressedFilesize: Int64;
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
    procedure CompressJPG(const AJPEG: TJPEGImage; const ACompressionQuality: integer);
    function SizeOfJPEG(const AJPEG: TJPEGImage): Int64;
    procedure TryCompression(const AQuality: integer=cMinQuality);
    procedure SetOutputDir(const Value: string);
    procedure RetryWithReducedScale;
  public
    constructor Create;
    destructor Destroy; override;
    function Process(const AFilename: string=''; const ASaveToDisk: boolean=true): boolean;
    procedure ShrinkAndRotate;
    function SaveToDisk: boolean;
    function SaveToStream: boolean;
    property SourceFilename: string read fSourceFilename;
    property OutputDir: string read fOutputDir write SetOutputDir;
    property ApplyGraphics: boolean read fApplyGraphics write fApplyGraphics;
    property Compress: boolean read fCompress write fCompress;
    property ShrinkByHeight: boolean read fShrinkByHeight write fShrinkByHeight;
    property ShrinkByMaxPx: integer read fShrinkByMaxPx write fShrinkByMaxPx;
    property CompressionQuality: integer read fCompressionQuality write fCompressionQuality;
    property TargetKB: integer read fTargetKB write fTargetKB;
    property OriginalFilesize: Int64 read fOriginalFilesize;
    property CompressedFilesize: Int64 read fCompressedFilesize;
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
  end;

implementation

{ TJPEGCompressor }

constructor TJPEGCompressor.Create;
begin
  inherited;
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

function TJPEGCompressor.Process(const AFilename: string=''; const ASaveToDisk: boolean=true): boolean;
begin
  try
    fMessages.Clear;
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
        fOriginalFilesize := Round(fMemoryStreamOrig.Size / cBytesToKB);
      end else begin
        fMemoryStreamOrig.Position := 0;
        fJPEG.LoadFromStream(fMemoryStreamOrig);
      end;
      ShrinkAndRotate;
      if fCompress then begin
        if fTargetKB > 0 then begin
          if (fCompressedFilesize = 0) or
             (fCompressedFilesize > fTargetKB) then begin
            fMinQuality := cScaleBelowQuality; //Retry with reduced scale beyond this level
            try
              TryCompression(cMaxQuality-cTargetInterval);
              if fCompressedFilesize > fTargetKB then
                RetryWithReducedScale;
            finally
              fMinQuality := cMinQuality;
            end;
          end;
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
      fMessages.Add('Processed '+ExtractFileName(fSourceFilename)+' in '+MilliSecondsBetween(fStartTime, fEndTime).ToString+'ms');
      fMessages.Add('Uncompressed file size (KB): '+fOriginalFilesize.ToString);
      fMessages.Add('Compressed file size (KB): '+fCompressedFilesize.ToString);
      fMessages.Add('JPEG Saved to: '+fOutputDir+ExtractFileName(fSourceFilename));
      if ASaveToDisk then
        SaveToDisk
      else
        SaveToStream;
    end else
      fMessages.Add(fSourceFilename+' not found');
  except
    on e: Exception do begin
      result := false;
      fMessages.Add('Error processing '+ExtractFileName(SourceFilename)+e.Classname+' '+e.Message);
    end;
  end;
end;

procedure TJPEGCompressor.RetryWithReducedScale;
var
  scale: TJPEGScale;
begin
  scale := jsFullSize;
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
      if fShrinkByHeight then
        reducePC := fShrinkByMaxPx / fJPEG.Height
      else
        reducePC := fShrinkByMaxPx / fJPEG.Width;
      case fResampleMode of
        rmNone: begin
          if (fShrinkByMaxPx > 0) and (fShrinkByMaxPx < size) then begin
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
        if fApplyGraphics and (not shrinked) and ((fShrinkByMaxPx > 0) and (fShrinkByMaxPx < size)) then
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

function TJPEGCompressor.SaveToDisk: boolean;
var
  outputFilename: string;
begin
  try
    if fReplaceOriginal then
      fJPEG.SaveToFile(fSourceFilename)
    else begin
      outputFilename := ExtractFileName(fSourceFilename);
      if FileExists(fOutputDir+outputFilename) then
        DeleteFile(fOutputDir+outputFilename)
      else
        ForceDirectories(fOutputDir);
      fJPEG.SaveToFile(fOutputDir+outputFilename);
    end;
    result := FileExists(fOutputDir+outputFilename);
  except
    on e: exception do begin
      result := false;
      fMessages.Add('Error saving JPEG to '+fOutputDir+outputFilename)
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