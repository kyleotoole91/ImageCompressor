unit uLicenseValidator;

interface

uses
  idHTTP, System.Net.HttpClient, System.Classes, Winapi.Windows, System.SysUtils, System.Win.Registry, SuperObject;

const
  cGumRoadPerma = 'ticw';
  cGumRoadPermaParam = 'product_permalink';
  cGumRoadKeyParam = 'license_key';
  cRegKey = 'Software\KOTSoftwareSolutions\TurboImageCompressor';
  cGumRoadTokenParam = 'access_token';
  cGumRoadIncUsesCount = 'increment_uses_count';
  cMaxUses = 3;

type
  TLicenseValidator = class(TObject)
  strict private
    fResp: IHTTPResponse;
    fReg: TRegistry;
    fJSON: ISuperObject;
    fMessage: string;
    fLicenseKey: string;
    fHTTP: THTTPClient;
    fParams: TStringList;
    procedure AddKeyToRegistry;

  public
    constructor Create;
    destructor Destroy; override;
    function LicenseIsValid(const AIncrementUsesCount: boolean=true): boolean;
    function GetLicenseKey: string;
    property LicenseKey: string read fLicenseKey write fLicenseKey;
    property Message: string read fMessage write fMessage;
  end;

implementation

const
  cGumRoadLicenseURL = 'https://api.gumroad.com/v2/licenses/verify';
  //cGumRoadDecrementURL = 'https://api.gumroad.com/v2/licenses/decrement_uses_count';

{ TLicenceValidator }

constructor TLicenseValidator.Create;
begin
  inherited;
  fHTTP := THTTPClient.Create;
  fParams := TStringList.Create;
end;

destructor TLicenseValidator.Destroy;
begin
  try
    fJSON := nil;
    fHTTP.Free;
    fParams.Free;
  finally
    inherited;
  end;
end;

function TLicenseValidator.LicenseIsValid(const AIncrementUsesCount: boolean=true): boolean;
var
  machinesLeft: integer;
begin
  result := false;
  try
    if fLicenseKey = '' then
      fLicenseKey := GetLicenseKey;
    if fLicenseKey = '' then
      fMessage := 'Please enter a license key'
    else begin
      fMessage := '';
      fParams.Clear;
      if AIncrementUsesCount then
        fParams.Add(cGumRoadIncUsesCount+'=true')
      else
        fParams.Add(cGumRoadIncUsesCount+'=false');
      fParams.Add(cGumRoadPermaParam+'='+cGumRoadPerma);
      fParams.Add(cGumRoadKeyParam+'='+fLicenseKey);
      fResp := fHTTP.Post(cGumRoadLicenseURL, fParams);
      fJSON := SO(fResp.ContentAsString);
      if fJSON.B['success'] and (fResp.StatusCode = 200) then begin
        if fJSON.B['refunded'] then
          fMessage := 'This key is no longer valid, you have been refuded for this product'
        else if fJSON.B['disputed'] or fJSON.B['dispute_won'] then
          fMessage := 'This key is not currently valid due to a dispute'
        else
          result := true;
      end else if fJSON.S['message'] <> '' then
        fMessage := fJSON.S['message'];
      if not result and (fMessage = '') then
        fMessage := 'The license key you entered is invalid'
      else if result then begin
        machinesLeft := (cMaxUses-fJSON.I['uses']);
        result := machinesLeft >= 0;
        if result then begin
          if machinesLeft = 0 then
            fMessage := 'Product activated! You cannot use this key on any more machines.'
          else if machinesLeft = 1 then
            fMessage := 'Product activated! You can use this key one more machine.'
          else
            fMessage := 'Product activated! You can use this key on '+machinesLeft.ToString+' more machine(s).';
          AddKeyToRegistry;
        end else
          fMessage := 'This key has been used on too many machines. Please purchase a new license key';
      end;
    end;
  except
    on e: exception do begin
      result := false;
      fMessage := e.ClassName+': '+e.Message;
    end;
  end;
end;

procedure TLicenseValidator.AddKeyToRegistry;
begin
  fReg := TRegistry.Create;
  try
    try
      fReg.RootKey := HKEY_CURRENT_USER;
      if not fReg.OpenKey(cRegKey, true) then
        RaiseLastOSError
      else
        fReg.WriteString('LicenseKey', fLicenseKey);
    except
      on e: exception do
        fMessage := e.ClassName+': '+e.Message;
    end;
  finally
    fReg.Free;
  end;
end;

function TLicenseValidator.GetLicenseKey: string;
begin
  result := '';
  fReg := TRegistry.Create;
  try
    try
      fReg.RootKey := HKEY_CURRENT_USER;
      if not fReg.OpenKey(cRegKey, false) then
        RaiseLastOSError
      else
        result := fReg.ReadString('LicenseKey');
    except
      on e: exception do
        fMessage := e.ClassName+': '+e.Message;
    end;
  finally
    fReg.Free;
  end;
end;

end.


