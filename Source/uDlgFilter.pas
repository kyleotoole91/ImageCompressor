unit uDlgFilter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TDlgFilter = class(TForm)
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fSize: uInt64;
    fRecordModified: boolean;
  public
    { Public declarations }
    property Size: uInt64 read fSize write fSize;
    property RecordModified: boolean read fRecordModified;
  end;

var
  DlgFilter: TDlgFilter;

implementation

{$R *.dfm}

procedure TDlgFilter.Button1Click(Sender: TObject);
begin
  fRecordModified := false;
  Close;
end;

procedure TDlgFilter.Button2Click(Sender: TObject);
begin
  fSize := SpinEdit1.Value;
  fRecordModified := true;
  Close;
end;

procedure TDlgFilter.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    fSize := SpinEdit1.Value;
    fRecordModified := true;
    Close;
  end else if Key = VK_ESCAPE then begin
    fRecordModified := false;
    Close;
  end;
end;

procedure TDlgFilter.FormShow(Sender: TObject);
begin
  SpinEdit1.Value := fSize;
end;

end.
