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

const
  // Exit codes
  EXIT_SUCCESS = 0;           // All files processed successfully
  EXIT_GENERAL_ERROR = 1;     // Invalid parameters, paths, or no files found
  EXIT_PARTIAL_FAILURE = 2;   // Some files failed to process
  EXIT_COMPLETE_FAILURE = 3;  // All files failed to process

  // Command line parameter indexes
  PARAM_EXE_NAME = 0;        // Index of executable name (ParamStr(0))
  PARAM_INPUT_PATH = 1;      // Index of input path parameter
  PARAM_OUTPUT_PATH = 2;     // Index of output path parameter
  PARAM_TARGET_KB = 3;       // Index of target KB parameter
  PARAM_MIN_COUNT = 3;       // Minimum number of required parameters

  // Command line parameter values
  PARAM_THUMBNAIL_FLAG = '-t';     // Flag to enable thumbnails
  PARAM_THUMBNAIL_SIZE = '-s';     // Flag to set thumbnail size
  DEFAULT_THUMBNAIL_SIZE = 150;    // Default thumbnail size in pixels

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
    fFailedCount: Integer;
    fProcessedCount: Integer;
    procedure ScanDirectory;
    procedure ProcessFiles;
    procedure SetupConfig;
    procedure ProcessSingleFile(const AFilePath: string);
    function GetExitCode: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function Execute: Integer;
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

function TConsoleCompressor.GetExitCode: Integer;
begin
  if fProcessedCount = 0 then
    Result := EXIT_GENERAL_ERROR
  else if fFailedCount = fProcessedCount then
    Result := EXIT_COMPLETE_FAILURE
  else if fFailedCount > 0 then
    Result := EXIT_PARTIAL_FAILURE
  else
    Result := EXIT_SUCCESS;
end;

function TConsoleCompressor.Execute: Integer;
var
  ExitCode: integer;
begin
  fFailedCount := 0;
  fProcessedCount := 0;

  if (fInputPath = '') or (fOutputPath = '') then
  begin
    WriteLn('Error: Input and output paths are required.');
    Exit(EXIT_GENERAL_ERROR);
  end;

  // Check if input is a file or directory
  if FileExists(fInputPath) then
  begin
    // Single file mode
    if not SameText(ExtractFileExt(fInputPath), '.jpg') and 
       not SameText(ExtractFileExt(fInputPath), '.jpeg') then
    begin
      WriteLn('Error: Input file must be a JPEG file');
      Exit(EXIT_GENERAL_ERROR);
    end;
    SetLength(fFilePaths, 1);
    fFilePaths[0] := fInputPath;
  end
  else if DirectoryExists(fInputPath) then
  begin
    // Directory mode
    ScanDirectory;
  end
  else
  begin
    WriteLn('Error: Input path does not exist: ' + fInputPath);
    Exit(EXIT_GENERAL_ERROR);
  end;

  if Length(fFilePaths) = 0 then
  begin
    WriteLn('Error: No JPEG files found to process.');
    Exit(EXIT_GENERAL_ERROR);
  end;
  
  // Create output directory if it doesn't exist
  if not DirectoryExists(fOutputPath) then
  begin
    try
      ForceDirectories(fOutputPath);
    except
      on E: Exception do
      begin
        WriteLn('Error: Failed to create output directory: ' + E.Message);
        Exit(EXIT_GENERAL_ERROR);
      end;
    end;
  end;
    
  SetupConfig;
  ProcessFiles;

  ExitCode := GetExitCode;

  // Print summary
  WriteLn('');
  WriteLn('Summary:');
  WriteLn('Total files processed: ' + fProcessedCount.ToString);
  WriteLn('Successful: ' + (fProcessedCount - fFailedCount).ToString);
  WriteLn('Failed: ' + fFailedCount.ToString);
  WriteLn('Exit Code: ' + fFailedCount.ToString);

  Result := ExitCode;
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
  Success: Boolean;
begin
  Inc(fProcessedCount);
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
    
    // Process the file and check result
    Success := fJPEGCompressor.Process(AFilePath);
    if not Success then
    begin
      Inc(fFailedCount);
      WriteLn('Failed to process ' + AFilePath);
      if fJPEGCompressor.Messages.Count > 0 then
        WriteLn(fJPEGCompressor.Messages.Text);
      Exit;
    end;
    
    WriteLn('Compressed: ' + AFilePath);
    WriteLn('Output: ' + fJPEGCompressor.OutputFilename);
    
    if fCreateThumbnails and (fJPEGCompressor.ThumbnailFilename <> '') then
      WriteLn('Thumbnail: ' + fJPEGCompressor.ThumbnailFilename);
      
    WriteLn('Original size: ' + (fJPEGCompressor.OriginalFileSize).ToString + ' KB');
    WriteLn('Compressed size: ' + (fJPEGCompressor.CompressedFileSize).ToString + ' KB');
    WriteLn('');
  except
    on E: Exception do
    begin
      Inc(fFailedCount);
      WriteLn('Error processing ' + AFilePath + ': ' + E.Message);
    end;
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
  ExitCode: Integer;
  
procedure PrintUsage;
begin
  WriteLn('Usage: TurboImageCompressorCLI.exe <input> <output_dir> <target_kb> [options]');
  WriteLn('Input can be:');
  WriteLn('  - Path to a single JPEG file');
  WriteLn('  - Path to a directory (will process all JPEG files in directory)');
  WriteLn('Options:');
  WriteLn('  -t           Create thumbnails');
  WriteLn('  -s <size>    Thumbnail size in pixels (default: 150)');
  WriteLn('');
  WriteLn('Examples:');
  WriteLn('  TurboImageCompressorCLI.exe C:\Images\photo.jpg C:\Output 500 -t -s 200');
  WriteLn('  TurboImageCompressorCLI.exe C:\Images C:\Output 500 -t -s 200');
end;

begin
  try
    if ParamCount < PARAM_MIN_COUNT then
    begin
      PrintUsage;
      ExitCode := EXIT_GENERAL_ERROR;
    end
    else
    begin
      Compressor := TConsoleCompressor.Create;
      try
        // Parse required parameters
        Compressor.InputPath := ParamStr(PARAM_INPUT_PATH);
        Compressor.OutputPath := ParamStr(PARAM_OUTPUT_PATH);
        Compressor.TargetKB := StrToIntDef(ParamStr(PARAM_TARGET_KB), 0);
        
        // Parse optional parameters
        var i := PARAM_TARGET_KB + 1;
        while i <= ParamCount do
        begin
          if ParamStr(i) = PARAM_THUMBNAIL_FLAG then
            Compressor.CreateThumbnails := True
          else if (ParamStr(i) = PARAM_THUMBNAIL_SIZE) and (i < ParamCount) then
          begin
            Inc(i);
            Compressor.ThumbnailSizePx := StrToIntDef(ParamStr(i), DEFAULT_THUMBNAIL_SIZE);
          end;
          Inc(i);
        end;
        
        ExitCode := Compressor.Execute;
      finally
        Compressor.Free;
      end;
    end;
    
  except
    on E: Exception do
    begin
      WriteLn('Error: ' + E.Message);
      ExitCode := EXIT_GENERAL_ERROR;
    end;
  end;
  
  Halt(ExitCode);
end.