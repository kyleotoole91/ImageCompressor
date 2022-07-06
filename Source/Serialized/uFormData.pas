unit uFormData;

interface

uses
  uImageConfig, uConstants, System.IOUtils, System.SysUtils;

type
  TFormData = class(TImageConfig)
  strict private
    fSourceDir: string;
    fOutputDir: string;
    fFilterSizeKB: Int64;
    fReplaceOriginals: boolean;
    fDeepScan: boolean;
    fPnlFilesWidth: integer;
    fPnlOriginalWidth: integer;
    fApplyToAll: boolean;
    fJsonFilename: string;
    fPrefix: string;
    fRunScript: boolean;
    fAutoPrefix: boolean;
  public
    constructor Create;
    procedure Reset;
    property SourceDir: string read fSourceDir write fSourceDir;
    property OutputDir: string read fOutputDir write fOutputDir;
    property FilterSizeKB: Int64 read fFilterSizeKB write fFilterSizeKB;
    property ReplaceOriginals: boolean read fReplaceOriginals write fReplaceOriginals;
    property DeepScan: boolean read fDeepScan write fDeepScan;
    property PnlFilesWidth: integer read fPnlFilesWidth write fPnlFilesWidth;
    property PnlOriginalWidth: integer read fPnlOriginalWidth write fPnlOriginalWidth;
    property ApplyToAll: boolean read fApplyToAll write fApplyToAll;
    property JsonFilename: string read fJsonFilename write fJsonFilename;
    property Prefix: string read fPrefix write fPrefix;
    property RunScript: boolean read fRunScript write fRunScript;
    property AutoPrefix: boolean read fAutoPrefix write fAutoPrefix;
  end;

implementation

{ TFormData }

constructor TFormData.Create;
begin
  inherited;
  Reset;
end;

procedure TFormData.Reset;
begin
  fApplyToAll := true;
  JsonFilename := cJSONFilename;
  fSourceDir := TPath.GetPicturesPath;
  fOutputDir := IncludeTrailingPathDelimiter(fSourceDir) + cDefaultOutDir;
  fPrefix := cDefaultSourcePrefix;
  fPnlFilesWidth := cDefaultFilesWidth;
  fPnlOriginalWidth := cDefaultOriginalWidth;
end;

end.
