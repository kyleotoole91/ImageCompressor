unit uFrmShellScript;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, uDynamicScript,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uConstants, DosCommand, System.UITypes, Vcl.Menus;

type
  TFrmShellScript = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnOK: TButton;
    btnClose: TButton;
    Panel3: TPanel;
    mmInput: TMemo;
    mmOutput: TMemo;
    Splitter1: TSplitter;
    btnRun: TButton;
    cbRunOnCompletion: TCheckBox;
    MainMenu1: TMainMenu;
    Insert1: TMenuItem;
    cbInsertVar: TMenuItem;
    Sourceprefixsaved1: TMenuItem;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OnTerminated(Sender: TObject);
    procedure mmInputChange(Sender: TObject);
    procedure cbRunOnCompletionClick(Sender: TObject);
    procedure cbInsertVarClick(Sender: TObject);
    procedure Sourceprefixsaved1Click(Sender: TObject);
  private
    fScriptRunner: TDynamicScript;
    fFile: TStringList;
    fRecordModified: boolean;
    fRunOnCompletion: boolean;
    fAllowSave: boolean;
    procedure SetRunOnCompletion(const Value: boolean);
    procedure SetOutputPath(const Value: string);
    procedure SetSourcePrefix(const Value: string);
  public
    property RecordModified: boolean read fRecordModified;
    property RunOnCompletion: boolean read fRunOnCompletion write SetRunOnCompletion;
    property AllowSave: boolean read fAllowSave write fAllowSave;
    property OutputPath: string write SetOutputPath;
    property SourcePrefix: string write SetSourcePrefix;
  end;

implementation

uses
  Winapi.ShellAPI;
{$R *.dfm}

procedure TFrmShellScript.FormCreate(Sender: TObject);
begin
  inherited;
  fAllowSave := false;
  fFile := TStringList.Create;
  fScriptRunner := TDynamicScript.Create(Self);
  fScriptRunner.OutputLines := mmOutput.Lines;
  fScriptRunner.DosCommand.OnTerminated := OnTerminated;
end;

procedure TFrmShellScript.FormDestroy(Sender: TObject);
begin
  try
    fFile.Free;
    try
      fScriptRunner.Free;
    except
    end;
  finally
    inherited;
  end;
end;

procedure TFrmShellScript.FormShow(Sender: TObject);
begin
  inherited;
  mmInput.Clear;
  mmoutput.Clear;
  if FileExists(cShellScript) then begin
    fFile.LoadFromFile(cShellScript);
    mmInput.Text := fFile.Text;
  end else
    MessageDlg(cMsgShellScriptWelcome, mtInformation, [mbOK], 0);
  mmInput.SetFocus;
end;

procedure TFrmShellScript.mmInputChange(Sender: TObject);
begin
  btnOK.Enabled := true;
end;

procedure TFrmShellScript.OnTerminated(Sender: TObject);
begin
  btnRun.Enabled := true;
  Screen.Cursor := crDefault;
end;

procedure TFrmShellScript.SetOutputPath(const Value: string);
begin
  fScriptRunner.OutputPath := Value;
end;

procedure TFrmShellScript.SetSourcePrefix(const Value: string);
begin
  fScriptRunner.SourcePrefix := Value;
end;

procedure TFrmShellScript.SetRunOnCompletion(const Value: boolean);
begin
  fRunOnCompletion := Value;
  cbRunOnCompletion.Checked := fRunOnCompletion;
end;

procedure TFrmShellScript.Sourceprefixsaved1Click(Sender: TObject);
begin
  mmInput.SelText := cShellPrefixVar;
end;

procedure TFrmShellScript.btnOKClick(Sender: TObject);
begin
  inherited;
  if not fAllowSave then begin
    if MessageDlg(cDeployScriptEval+sLineBreak+sLineBreak+cLinkToBuyMessage, mtWarning, mbOKCancel, 0) = mrOk then
      ShellExecute(0, 'open', PChar(cGumRoadLink), nil, nil, SW_SHOWNORMAL);
  end else begin
    fRecordModified := true;
    fFile.Clear;
    fFile.Text := mmInput.Text;
    fFile.SaveToFile(cShellScript);
    fRunOnCompletion := cbRunOnCompletion.Checked;
    Close;
  end;
end;

procedure TFrmShellScript.cbInsertVarClick(Sender: TObject);
begin
  mmInput.SelText := cShellOutputPathVar;
end;

procedure TFrmShellScript.cbRunOnCompletionClick(Sender: TObject);
begin
  btnOK.Enabled := true;
end;

procedure TFrmShellScript.btnCloseClick(Sender: TObject);
begin
  inherited;
  fRecordModified := false;
  Close;
end;

procedure TFrmShellScript.btnRunClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;
  btnRun.Enabled := false;
  mmOutput.Lines.Clear;
  fFile.Text := mmInput.Text;
  fFile.SaveToFile(cShellTestScript);
  fScriptRunner.ScriptFilename := cShellTestScript;
  fScriptRunner.RunScript;
end;

end.
