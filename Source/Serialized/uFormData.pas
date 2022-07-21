unit uFormData;

interface

uses
  uImageConfig, uConstants, System.IOUtils, System.SysUtils;

type
  TFormData = class(TImageConfig)
  strict private
    fCreateThumbnails: boolean;
    fSourceDir: string;
    fOutputDir: string;
    fFilterSizeKB: Int64;
    fReplaceOriginals: boolean;
    fDeepScan: boolean;
    fPnlFilesWidth: integer;
    fPnlOriginalWidth: integer;
    fApplyToAll: boolean;
    fJSONFilename: string;
    fSourcePrefix: string;
    fRunScript: boolean;
    fAutoPrefix: boolean;
  public
    constructor Create;
    procedure Reset; override;
    property SourceDir: string read fSourceDir write fSourceDir;
    property OutputDir: string read fOutputDir write fOutputDir;
    property FilterSizeKB: Int64 read fFilterSizeKB write fFilterSizeKB;
    property ReplaceOriginals: boolean read fReplaceOriginals write fReplaceOriginals;
    property DeepScan: boolean read fDeepScan write fDeepScan;
    property PnlFilesWidth: integer read fPnlFilesWidth write fPnlFilesWidth;
    property PnlOriginalWidth: integer read fPnlOriginalWidth write fPnlOriginalWidth;
    property ApplyToAll: boolean read fApplyToAll write fApplyToAll;
    property JSONFilename: string read fJSONFilename write fJSONFilename;
    property SourcePrefix: string read fSourcePrefix write fSourcePrefix;
    property RunScript: boolean read fRunScript write fRunScript;
    property AutoPrefix: boolean read fAutoPrefix write fAutoPrefix;
    property CreateThumbnails: boolean read fCreateThumbnails write fCreateThumbnails;
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
  inherited;
  fApplyToAll := true;
  fCreateThumbnails := false;
  fJSONFilename := cJSONFilename;
  fSourceDir := TPath.GetPicturesPath;
  fOutputDir := IncludeTrailingPathDelimiter(fSourceDir) + cDefaultOutDir;
  fSourcePrefix := cDefaultSourcePrefix;
  fPnlFilesWidth := cDefaultFilesWidth;
  fPnlOriginalWidth := cDefaultOriginalWidth;
end;

end.
