program TurboImageCompressorCLI;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.IOUtils,
  System.Types,
  Winapi.Windows,
  Vcl.Graphics,
  Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage,
  Vcl.Imaging.GIFImg,
  superobject,
  supertypes,
  Img32,
  Img32.Fmt.JPG,
  uJPEGCompressor in '.\Source\Utilis\uJPEGCompressor.pas',
  uImageConfig in '.\Source\Serialized\uImageConfig.pas';

type
  TConsoleCompressor = class
  private
    fJPEGCompressor: TJPEGCompressor;
    fImageConfig: TImageConfig;
    fInputPath: string;
    fOutputPath: string;
    fTargetKB: Integer;
    fCreateThumbnails: Boolean;
    fThumbnailSizePx: Integer;
    fFilePaths: TArray<string>;
    procedure ScanDirectory;
    procedure ProcessFiles;
    procedure SetupConfig;
    procedure ProcessSingleFile(const AFilePath: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute;
    property InputPath: string read fInputPath write fInputPath;
    property OutputPath: string read fOutputPath write fOutputPath;
    property TargetKB: Integer read fTargetKB write fTargetKB;
    property CreateThumbnails: Boolean read fCreateThumbnails write fCreateThumbnails;
    property ThumbnailSizePx: Integer read fThumbnailSizePx write fThumbnailSizePx;
  end;

{ TConsoleCompressor }

constructor TConsoleCompressor.Create;
begin
  inherited Create;
  fJPEGCompressor := TJPEGCompressor.Create;
  fImageConfig := TImageConfig.Create;
  fThumbnailSizePx := 150; // Default thumbnail size
end;

destructor TConsoleCompressor.Destroy;
begin
  fJPEGCompressor.Free;
  fImageConfig.Free;
  inherited;
end;

procedure TConsoleCompressor.Execute;
begin
  if (fInputPath = '') or (fOutputPath = '') then
  begin
    WriteLn('Error: Input and output paths are required.');
    Exit;
  end;
  
  if not DirectoryExists(fInputPath) then
  begin
    WriteLn('Error: Input directory does not exist: ' + fInputPath);
    Exit;
  end;
  
  // Create output directory if it doesn't exist
  if not DirectoryExists(fOutputPath) then
    ForceDirectories(fOutputPath);
    
  SetupConfig;
  ScanDirectory;
  ProcessFiles;
end;

procedure TConsoleCompressor.SetupConfig;
begin
  // Configure compression settings
  fImageConfig.TargetKB := fTargetKB;
  fImageConfig.Compress := True;
  
  // Configure JPEG compressor
  fJPEGCompressor.CreateThumbnail := fCreateThumbnails;
  fJPEGCompressor.ThumbnailSizePx := fThumbnailSizePx;
  fJPEGCompressor.OutputDir := fOutputPath;
  fJPEGCompressor.Compress := True;
  fJPEGCompressor.TargetKB := fTargetKB;
end;

procedure TConsoleCompressor.ScanDirectory;
var
  AllFiles: TArray<string>;
  FilePath: string;
  OutputDirName: string;
begin
  WriteLn('Scanning directory: ' + fInputPath);
  AllFiles := TDirectory.GetFiles(fInputPath, '*.jp*g', TSearchOption.soAllDirectories);
  SetLength(fFilePaths, 0);
  OutputDirName := ExtractFileName(ExcludeTrailingPathDelimiter(fOutputPath));
  
  // Filter out files that are in the output directory
  for FilePath in AllFiles do
  begin
    // Only include files that are not in or under the output directory
    if Pos(OutputDirName + PathDelim, ExtractRelativePath(fInputPath, FilePath)) = 0 then
    begin
      SetLength(fFilePaths, Length(fFilePaths) + 1);
      fFilePaths[High(fFilePaths)] := FilePath;
    end;
  end;
  
  WriteLn('Found ' + Length(fFilePaths).ToString + ' JPEG files');
end;

procedure TConsoleCompressor.ProcessSingleFile(const AFilePath: string);
var
  RelativePath: string;
  OutputFileName: string;
begin
  try
    // Get relative path to preserve directory structure
    RelativePath := ExtractRelativePath(fInputPath, AFilePath);
    
    // Set output directory
    if TPath.GetDirectoryName(RelativePath) <> '' then
      fJPEGCompressor.OutputDir := TPath.Combine(fOutputPath, TPath.GetDirectoryName(RelativePath))
    else
      fJPEGCompressor.OutputDir := fOutputPath;
      
    // Set output filename explicitly
    OutputFileName := TPath.Combine(fJPEGCompressor.OutputDir, TPath.GetFileName(AFilePath));
    fJPEGCompressor.OutputFilename := OutputFileName;
      
    // Create output directory if needed
    if not DirectoryExists(fJPEGCompressor.OutputDir) then
      ForceDirectories(fJPEGCompressor.OutputDir);
    
    // Process the file
    fJPEGCompressor.Process(AFilePath);
    
    WriteLn('Compressed: ' + AFilePath);
    WriteLn('Output: ' + fJPEGCompressor.OutputFilename);
    
    if fCreateThumbnails and (fJPEGCompressor.ThumbnailFilename <> '') then
      WriteLn('Thumbnail: ' + fJPEGCompressor.ThumbnailFilename);
      
    WriteLn('Original size: ' + (fJPEGCompressor.OriginalFileSize).ToString + ' KB');
    WriteLn('Compressed size: ' + (fJPEGCompressor.CompressedFileSize).ToString + ' KB');
    WriteLn('');
  except
    on E: Exception do
      WriteLn('Error processing ' + AFilePath + ': ' + E.Message);
  end;
end;

procedure TConsoleCompressor.ProcessFiles;
var
  FilePath: string;
begin
  WriteLn('Starting compression...');
  WriteLn('');
  
  for FilePath in fFilePaths do
    ProcessSingleFile(FilePath);
    
  WriteLn('Compression complete.');
  WriteLn('Processed ' + Length(fFilePaths).ToString + ' files');
end;

var
  Compressor: TConsoleCompressor;
  
procedure PrintUsage;
begin
  WriteLn('Usage: TurboImageCompressorCLI.exe <input_dir> <output_dir> <target_kb> [options]');
  WriteLn('Options:');
  WriteLn('  -t           Create thumbnails');
  WriteLn('  -s <size>    Thumbnail size in pixels (default: 150)');
  WriteLn('');
  WriteLn('Example:');
  WriteLn('  TurboImageCompressorCLI.exe C:\Images C:\Output 500 -t -s 200');
end;

begin
  try
    if ParamCount < 3 then
    begin
      PrintUsage;
      Exit;
    end;
    
    Compressor := TConsoleCompressor.Create;
    try
      // Parse required parameters
      Compressor.InputPath := ParamStr(1);
      Compressor.OutputPath := ParamStr(2);
      Compressor.TargetKB := StrToIntDef(ParamStr(3), 0);
      
      // Parse optional parameters
      var i := 4;
      while i <= ParamCount do
      begin
        if ParamStr(i) = '-t' then
          Compressor.CreateThumbnails := True
        else if (ParamStr(i) = '-s') and (i < ParamCount) then
        begin
          Inc(i);
          Compressor.ThumbnailSizePx := StrToIntDef(ParamStr(i), 150);
        end;
        Inc(i);
      end;
      
      Compressor.Execute;
    finally
      Compressor.Free;
    end;
    
  except
    on E: Exception do
      WriteLn('Error: ' + E.Message);
  end;
end.