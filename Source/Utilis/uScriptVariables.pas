unit uScriptVariables;

interface

uses
  SysUtils, System.IOUtils, Classes, uConstants, DosCommand, SuperObject;

type
  TScriptVariables = class(TObject)
  private
    fFile: TStringList;
    fOutputPath,
    fSourcePrefix: string;
    fScriptFilename: string;
    fOutputFile: string;
    fOutputLines: TStrings;
    fDosCommand: TDosCommand;
    fErrorMsg: string;
    procedure SetOutputLines(const Value: TStrings);
    procedure LoadSavedSettings;
  public
    constructor Create(const AOwner: TComponent);
    destructor Destroy; override;
    function Parse: string;
    procedure RunScript;
    property ErrorMsg: string read fErrorMsg write fErrorMsg;
    property OutputLines: TStrings read fOutputLines write SetOutputLines;
    property ScriptFilename: string read fScriptFilename write fScriptFilename;
    property OutputFile: string read fOutputFile;
    property DosCommand: TDosCommand read fDosCommand;
    property OutputPath: string read fOutputPath write fOutputPath;
    property SourcePrefix: string read fOutputPath write fSourcePrefix;
  end;

implementation

{ TScriptVariables }

constructor TScriptVariables.Create(const AOwner: TComponent);
begin
  inherited Create;
  fErrorMsg := '';
  fFile := TStringList.Create;
  fDosCommand := TDosCommand.Create(AOwner);
end;

destructor TScriptVariables.Destroy;
begin
  try
    fDosCommand.Free;
    fFile.Free;
  finally
    inherited;
  end;
end;

procedure TScriptVariables.LoadSavedSettings;
var
  so: ISuperObject;
begin
  try
    so := TSuperObject.ParseFile(cSettingsFilename, false);
    fOutputPath := so.S[cOutputDir];
    fSourcePrefix := so.S[cPrefix];
  finally
    so := nil;
  end;
end;

function TScriptVariables.Parse: string;
begin
  fOutputFile := '';
  result := '';
  try
    if (fScriptFilename <> '') and
       (FileExists(fScriptFilename)) then begin
      if fOutputPath = '' then
        LoadSavedSettings;
      fFile.LoadFromFile(fScriptFilename);
      fOutputFile := fFile.Text.Replace(cShellOutputPathVar, fOutputPath)
                               .Replace(cShellPrefixVar, fSourcePrefix);
    end;
  finally
    result := fOutputFile;
  end;
end;

procedure TScriptVariables.RunScript;
var
  scriptFile,
  original: TStringList;
begin
  fErrorMsg := '';
  scriptFile := TStringList.Create;
  original := TStringList.Create;
  try
    try
      original.LoadFromFile(fScriptFilename);
      scriptFile.Text := Parse;
      scriptFile.SaveToFile(cShellTempScript);
      fDosCommand.CommandLine := 'cmd /c "'+cShellTempScript+'"';
      fDosCommand.Execute;
    except
      on e: exception do
        fErrorMsg := e.ClassName+' '+e.Message;
    end;
  finally
    original.Free;
    scriptFile.Free;
  end;
end;

procedure TScriptVariables.SetOutputLines(const Value: TStrings);
begin
  fDosCommand.OutputLines := Value;
end;

end.
