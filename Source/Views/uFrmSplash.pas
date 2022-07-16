unit uFrmSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg, Winapi.ShellAPI,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, uLicenseValidator, uConstants, SuperObject, System.StrUtils;

type
  TfrmSplash = class(TForm)
    Timer1: TTimer;
    pnlMain: TPanel;
    lbYear: TLabel;
    Label1: TLabel;
    lbVersion: TLabel;
    Image1: TImage;
    lbMessage: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fVersion,
    fLatestVersion: string;
    fLicenseValidator: TLicenseValidator;
    fHasValidLicense,
    fStartApp: boolean;
    function AlreadyAskedVersion: boolean;
    procedure RecordVersionPrompt;
  public
    { Public declarations }
    property StartApp: boolean read fStartApp;
    property HasValidLicense: boolean read fHasValidLicense;
    function UpdateAvailable: boolean;
  end;

  procedure GetBuildInfo(var V1, V2, V3, V4: word);
  function GetBuildInfoAsString: string;

var
  frmSplash: TfrmSplash;

implementation

uses
  System.UITypes, DateUtils, System.Net.HttpClient, System.Win.Registry;

{$R *.dfm}
procedure TfrmSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  inherited;
  fLicenseValidator := TLicenseValidator.Create;
  Timer1.Interval := 1;
  lbYear.Caption := lbYear.Caption+FormatDateTime('YYYY', Now);
  pnlMain.Color := cSplashBGColor;
end;

procedure TfrmSplash.FormDestroy(Sender: TObject);
begin
  fLicenseValidator.Free;
  inherited;
end;

procedure TfrmSplash.FormShow(Sender: TObject);
begin
  inherited;
  fVersion := GetBuildInfoAsString;
  lbVersion.Caption := 'V'+fVersion;
  fStartApp := true;
  fHasValidLicense := false;
  Timer1.Enabled := true;
end;

function TfrmSplash.UpdateAvailable: boolean;
var
  http: THTTPClient;
  json: ISuperObject;
begin
  Screen.Cursor := crHourGlass;
  http := THTTPClient.Create;
  fLatestVersion := '';
  try
    try
      json := SO(http.Get(cVersionFile).ContentAsString);
      result := Assigned(json) and (json.S['TurboImageCompressor'] <> '');
      if result then
        fLatestVersion := json.S['TurboImageCompressor'];
    except
      result := false;
    end;
  finally
    Screen.Cursor := crDefault;
    json := nil;
    http.Free;
  end;
end;

procedure TfrmSplash.Timer1Timer(Sender: TObject);
var
  licenseKey: string;
begin
  try
    Timer1.Enabled := false;
    Screen.Cursor := crHourGlass;
    licenseKey := fLicenseValidator.GetLicenseKey;
    lbMessage.Caption := cMsgCheckingLicense;
    Application.ProcessMessages;
    fHasValidLicense := fLicenseValidator.LicenseIsValid(false);
    if not fHasValidLicense then begin
      Screen.Cursor := crDefault;
      if licenseKey <> '' then begin
        lbMessage.Caption := cMsgLicenseNotValid;
        MessageDlg(cMsgLicenseCouldNotValidate+fLicenseValidator.Message, TMsgDlgType.mtError, [mbOk], 0);
      end;
      lbMessage.Caption := cStartingFreeVersion;
    end else
      lbMessage.Caption := cStartingProVersion;
    if UpdateAvailable and
       (not AlreadyAskedVersion) then begin
      if (fLatestVersion <> fVersion) and
         (MessageDlg(Format(cMsgNewerVersionAvailble, [fLatestVersion]), TMsgDlgType.mtError, [mbYes, mbNo], 0) = mrYes) then begin
        fStartApp := false;
        ShellExecute(0, 'open', PChar(cLatestVersionURL), nil, nil, SW_SHOWNORMAL);
      end;
      RecordVersionPrompt;
    end;
  finally
    Application.ProcessMessages;
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

function TfrmSplash.AlreadyAskedVersion: boolean;
begin
  result := false;
  with TRegistry.Create do begin
    try
      try
        RootKey := HKEY_CURRENT_USER;
        if OpenKey(cRegKey, false) then
          result := (ReadString(cLastMessageVersion) <> '') and
                    (ReadString(cLastMessageVersion) = fLatestVersion);
      except
        result := false;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TfrmSplash.RecordVersionPrompt;
begin
  with TRegistry.Create do begin
    try
      try
        RootKey := HKEY_CURRENT_USER;
        if OpenKey(cRegKey, false) then
          WriteString(cLastMessageVersion, fLatestVersion);
      except
      end;
    finally
      Free;
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
