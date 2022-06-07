unit uLicenseValidator;

interface

uses
  idHTTP, System.Net.HttpClient, System.Classes, Winapi.Windows, System.SysUtils, System.Win.Registry, SuperObject;

const
  cGumRoadPerma = 'ticw';
  cGumRoadPermaParam = 'product_permalink';
  cGumRoadKeyParam = 'license_key';
  cRegKey = 'Software\KOTSoftwareSolutions\TurboImageCompressor';

type
  TLicenseValidator = class(TObject)
  strict private
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
    function LicenseIsValid: boolean;
    function GetLicenseKey: string;
    property LicenseKey: string read fLicenseKey write fLicenseKey;
    property Message: string read fMessage write fMessage;
  end;

implementation

const
  cGumRoadLicenseURL = 'https://api.gumroad.com/v2/licenses/verify';

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

function TLicenseValidator.LicenseIsValid: boolean;
var
  resp: IHTTPResponse;
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
      fParams.Add(cGumRoadPermaParam+'='+cGumRoadPerma);
      fParams.Add(cGumRoadKeyParam+'='+fLicenseKey);
      resp := fHTTP.Post(cGumRoadLicenseURL, fParams);
      fJSON := SO(resp.ContentAsString);
      if fJSON.B['success'] and (resp.StatusCode = 200) then begin
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
        fMessage := 'Product activated!';
        AddKeyToRegistry;
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


