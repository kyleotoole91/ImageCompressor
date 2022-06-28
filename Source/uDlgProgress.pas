unit uDlgProgress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TDlgProgress = class(TForm)
    Label1: TLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DlgProgress: TDlgProgress;

implementation

{$R *.dfm}

procedure TDlgProgress.FormDestroy(Sender: TObject);
begin
  Close;
  inherited;
end;

end.
