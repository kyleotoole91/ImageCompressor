unit uDynamicScript;

interface

uses
  SysUtils, System.IOUtils, Classes, uConstants, DosCommand, SuperObject;

type
  TDynamicScript = class(TObject)
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

{ TDynamicScript }

constructor TDynamicScript.Create(const AOwner: TComponent);
begin
  inherited Create;
  fErrorMsg := '';
  fOutputPath := '';
  fSourcePrefix := '';
  fFile := TStringList.Create;
  fDosCommand := TDosCommand.Create(AOwner);
  fScriptFilename := cShellScript;
end;

destructor TDynamicScript.Destroy;
begin
  try
    fDosCommand.Free;
    fFile.Free;
  finally
    inherited;
  end;
end;

function TDynamicScript.Parse: string;
begin
  fOutputFile := '';
  result := '';
  try
    fFile.LoadFromFile(fScriptFilename);
    fOutputFile := fFile.Text.Replace(cShellOutputPathVar, fOutputPath)
                             .Replace(cShellPrefixVar, fSourcePrefix);
  finally
    result := fOutputFile;
  end;
end;

procedure TDynamicScript.RunScript;
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

procedure TDynamicScript.SetOutputLines(const Value: TStrings);
begin
  fDosCommand.OutputLines := Value;
end;

end.
