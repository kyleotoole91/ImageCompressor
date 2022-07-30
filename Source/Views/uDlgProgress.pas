unit uDlgProgress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TDlgProgress = class(TForm)
    Label1: TLabel;
    pbProgress: TProgressBar;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetText(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    procedure ResetProgress;
    property Text: string write SetText;
    property ProgressBar: TProgressBar read pbProgress;
  end;

implementation

{$R *.dfm}

procedure TDlgProgress.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Screen.Cursor := crDefault;
end;

procedure TDlgProgress.FormCreate(Sender: TObject);
begin
  ResetProgress;
end;

procedure TDlgProgress.FormDestroy(Sender: TObject);
begin
  Close;
end;

procedure TDlgProgress.FormShow(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  ResetProgress;
end;

procedure TDlgProgress.ResetProgress;
begin
  pbProgress.Min := 0;
  pbProgress.Max := 100;
  pbProgress.Step := 1;
  pbProgress.Position := 1;
end;

procedure TDlgProgress.SetText(const Value: string);
begin
  Label1.Caption := Value
end;

end.
