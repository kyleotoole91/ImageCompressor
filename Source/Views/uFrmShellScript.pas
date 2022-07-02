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
    Button2: TButton;
    Panel3: TPanel;
    mmInput: TMemo;
    mmOutput: TMemo;
    cbRunOnCompletion: TCheckBox;
    btnRun: TButton;
    procedure Button2Click(Sender: TObject);
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
  public
    property RecordModified: boolean read fRecordModified;
    property RunOnCompletion: boolean read fRunOnCompletion write fRunOnCompletion;
  end;

implementation

{$R *.dfm}

procedure TFrmShellScript.FormCreate(Sender: TObject);
begin
  inherited;
  fFile := TStringList.Create;
  fDosCommand := TDosCommand.Create(Self);
  mmInput.Lines.Clear;
  mmOutput.Lines.Clear;
end;

procedure TFrmShellScript.FormShow(Sender: TObject);
begin
  inherited;
  if FileExists(cShellScript) then begin
    fFile.LoadFromFile(cShellScript);
    mmInput.Text := fFile.Text;
  end else
    MessageDlg(cMsgShellScriptWelcome, mtInformation, [mbOK], 0);
  mmInput.SetFocus;
end;

procedure TFrmShellScript.btnOKClick(Sender: TObject);
begin
  inherited;
  fRecordModified := true;
  fFile.Clear;
  fFile.Text := mmInput.Text;
  fFile.SaveToFile(cShellScript);
  fRunOnCompletion := cbRunOnCompletion.Checked;
  Close;
end;

procedure TFrmShellScript.Button2Click(Sender: TObject);
begin
  inherited;
  fRecordModified := false;
  Close;
end;

procedure TFrmShellScript.btnRunClick(Sender: TObject);
begin
  inherited;
  fFile.Text := mmInput.Text;
  fFile.SaveToFile(cShellScript);
  fDosCommand.CommandLine := fFile.Text;
  fDosCommand.Execute;
  mmOutput.Lines := fDosCommand.Lines;
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
