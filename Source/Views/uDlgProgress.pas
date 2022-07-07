unit uDlgProgress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TDlgProgress = class(TForm)
    Label1: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure SetText(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property Text: string write SetText;
  end;

implementation

{$R *.dfm}

procedure TDlgProgress.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Screen.Cursor := crDefault;
end;

procedure TDlgProgress.FormDestroy(Sender: TObject);
begin
  Close;
  inherited;
end;

procedure TDlgProgress.FormShow(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
end;

procedure TDlgProgress.SetText(const Value: string);
begin
  Label1.Caption := Value
end;

end.
