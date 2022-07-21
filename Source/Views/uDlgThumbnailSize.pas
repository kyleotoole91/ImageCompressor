unit uDlgThumbnailSize;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, System.UITypes;

type
  TDlgThumbnailSize = class(TForm)
    Label1: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    seMaxDimensions: TSpinEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    fRecordModified: boolean;
    fSizePx: integer;
    procedure SetSizePx(const Value: integer);
  public
    { Public declarations }
    property SizePx: integer read fSizePx write SetSizePx;
    property RecordModified: boolean read fRecordModified;
  end;

implementation

{$R *.dfm}

procedure TDlgThumbnailSize.btnCancelClick(Sender: TObject);
begin
  fRecordModified := false;
  Close;
end;

procedure TDlgThumbnailSize.btnOKClick(Sender: TObject);
begin
  if seMaxDimensions.Value >= 1 then begin
    fRecordModified := true;
    fSizePx := seMaxDimensions.Value;
    Close;
  end else
    MessageDlg('The value must be positive', TMsgDlgType.mtError, [mbOk], 0);
end;

procedure TDlgThumbnailSize.SetSizePx(const Value: integer);
begin
  fSizePx := Value;
  seMaxDimensions.Value := fSizePx;
end;

end.
