unit uFrmShellScript;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uConstants, DosCommand, System.UITypes;

type
  TFrmShellScript = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    Panel3: TPanel;
    mmInput: TMemo;
    mmOutput: TMemo;
    Splitter1: TSplitter;
    btnRun: TButton;
    cbRunOnCompletion: TCheckBox;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fFile: TStringList;
    fDosCommand: TDosCommand;
    fRecordModified: boolean;
    fRunOnCompletion: boolean;
    fAllowSave: boolean;
    procedure SetRunOnCompletion(const Value: boolean);
  public
    property RecordModified: boolean read fRecordModified;
    property RunOnCompletion: boolean read fRunOnCompletion write SetRunOnCompletion;
    property AllowSave: boolean read fAllowSave write fAllowSave;
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
  fDosCommand := TDosCommand.Create(Self);
  fDosCommand.OutputLines := mmOutput.Lines;
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

procedure TFrmShellScript.SetRunOnCompletion(const Value: boolean);
begin
  fRunOnCompletion := Value;
  cbRunOnCompletion.Checked := fRunOnCompletion;
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

procedure TFrmShellScript.btnCancelClick(Sender: TObject);
begin
  inherited;
  fRecordModified := false;
  Close;
end;

procedure TFrmShellScript.btnRunClick(Sender: TObject);
begin
  inherited;
  mmOutput.Lines.Clear;
  fFile.Text := mmInput.Text;
  fFile.SaveToFile(cShellTestScript);
  fDosCommand.CommandLine := 'cmd /c "'+cShellTestScript+'"';
  fDosCommand.Execute;
end;

procedure TFrmShellScript.FormDestroy(Sender: TObject);
begin
  try
    fFile.Free;
    fDosCommand.Free;
  finally
    inherited;
  end;
end;

end.
