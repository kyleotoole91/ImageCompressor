unit uFrmSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, uLicenseValidator;

type
  TfrmSplash = class(TForm)
    Timer1: TTimer;
    pnlMain: TPanel;
    lbYear: TLabel;
    Label1: TLabel;
    lbVersion: TLabel;
    Image1: TImage;
    lbMessage: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fLicenseValidator: TLicenseValidator;
    fHasValidLicense: boolean;
  public
    { Public declarations }
    property HasValidLicense: boolean read fHasValidLicense;
  end;

  procedure GetBuildInfo(var V1, V2, V3, V4: word);
  function GetBuildInfoAsString: string;

var
  frmSplash: TfrmSplash;

implementation

uses
  System.UITypes, DateUtils;

{$R *.dfm}

procedure TfrmSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  inherited;
  fHasValidLicense := false;
  fLicenseValidator := TLicenseValidator.Create;
  lbVersion.Caption := 'V'+GetBuildInfoAsString;
  Timer1.Interval := 1;
  lbYear.Caption := lbYear.Caption+FormatDateTime('YYYY', Now);
  pnlMain.Color := 5209163;
end;

procedure TfrmSplash.FormDestroy(Sender: TObject);
begin
  fLicenseValidator.Free;
  inherited;
end;

procedure TfrmSplash.FormShow(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := true;
end;

procedure TfrmSplash.Timer1Timer(Sender: TObject);
var
  startTime: TDateTime;
begin
  startTime := Now;
  try
    Timer1.Enabled := false;
    Screen.Cursor := crHourGlass;
    lbMessage.Caption := 'Checking license, please wait...';
    Application.ProcessMessages;
    {$IFDEF DEBUG}
    Sleep(1500); //Simulate slow startup, gives time to check splash screen layout
    {$ENDIF}
    fHasValidLicense := fLicenseValidator.LicenseIsValid(false);
    if not fHasValidLicense then begin
      Screen.Cursor := crDefault;
      if fLicenseValidator.GetLicenseKey <> '' then begin
        lbMessage.Caption := 'Your license key could not be validated.';
        MessageDlg('Your license key could not be validated.'+sLineBreak+
                   'The free version of the application will now launch. '+sLineBreak+sLineBreak+
                   'Error returned:'+sLineBreak+
                    fLicenseValidator.Message, TMsgDlgType.mtError, [mbOk], 0);
      end;
      lbMessage.Caption := 'Starting Free version..';
    end else
      lbMessage.Caption := 'Starting Pro version...';
  finally
    Application.ProcessMessages;
    if MilliSecondsBetween(Now, startTime) < 500 then
      Sleep(500); //Give time to read which version is launching
    Screen.Cursor := crDefault;
    Close;
  end;
end;

procedure GetBuildInfo(var V1, V2, V3, V4: word);
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  if VerInfoSize > 0 then
  begin
      GetMem(VerInfo, VerInfoSize);
      try
        if GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo) then
        begin
          VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
          with VerValue^ do
          begin
            V1 := dwFileVersionMS shr 16;
            V2 := dwFileVersionMS and $FFFF;
            V3 := dwFileVersionLS shr 16;
            V4 := dwFileVersionLS and $FFFF;
          end;
        end;
      finally
        FreeMem(VerInfo, VerInfoSize);
      end;
  end;
end;

function GetBuildInfoAsString: string;
var
  V1, V2, V3, V4: word;
begin
  GetBuildInfo(V1, V2, V3, V4);
  Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' +
    IntToStr(V3) + '.' + IntToStr(V4);
end;

end.
