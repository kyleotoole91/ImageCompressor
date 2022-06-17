unit uLicenseValidator;

interface

uses
  idHTTP, System.Net.HttpClient, System.Classes, Winapi.Windows, System.SysUtils, System.Win.Registry, SuperObject;

const
  cGumRoadLicenseURL = 'https://api.gumroad.com/v2/licenses/verify';
  cGumRoadPerma = 'ticw';
  cGumRoadPermaParam = 'product_permalink';
  cGumRoadKeyParam = 'license_key';
  cRegKey = 'Software\KOTSoftwareSolutions\TurboImageCompressor';
  cGumRoadTokenParam = 'access_token';
  cGumRoadIncUsesCount = 'increment_uses_count';
  cLicenseKeyReg = 'LicenseKey';
  cUses = 'uses';
  cMessage = 'message';
  {$IFDEF DEBUG}
  cMaxUses = 100;
  {$ELSE}
  cMaxUses = 3;
  {$ENDIF}

type
  TLicenseValidator = class(TObject)
  strict private
    fResp: IHTTPResponse;
    fJSON: ISuperObject;
    fMessage: string;
    fLicenseKey: string;
    fHTTP: THTTPClient;
    fParams: TStringList;
    procedure AddKeyToRegistry;
  public
    constructor Create;
    destructor Destroy; override;
    procedure DeleteLicense;
    function LicenseIsValid(const AIncrementUsesCount: boolean=true; const ARetry: boolean=true): boolean;
    function GetLicenseKey: string;
    property LicenseKey: string read fLicenseKey write fLicenseKey;
    property Message: string read fMessage write fMessage;
  end;

implementation

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

function TLicenseValidator.LicenseIsValid(const AIncrementUsesCount: boolean=true; const ARetry: boolean=true): boolean;
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
      end else if fJSON.S[cMessage] <> '' then
        fMessage := fJSON.S[cMessage];
      if not result and (fMessage = '') then
        fMessage := 'The license key you entered is invalid'
      else if result then begin
        machinesLeft := (cMaxUses-fJSON.I[cUses]);
        result := machinesLeft >= 0;
        if result then begin
          if machinesLeft = 0 then
            fMessage := 'Product activated!'+sLineBreak+sLineBreak+'This key cannot be used any more times.'
          else if machinesLeft = 1 then
            fMessage := 'Product activated! '+sLineBreak+sLineBreak+'This key can be used one more time.'
          else
            fMessage := 'Product activated!'+sLineBreak+sLineBreak+'This key can be used '+machinesLeft.ToString+' more times.';
          AddKeyToRegistry;
        end else
          fMessage := 'This key has been used too many times. '+sLineBreak+sLineBreak+
                      'Please contact us from the purchase page or purchase a new license key';
      end;
    end;
  except
    on e: exception do begin
      result := false;
      if ARetry then begin
        Sleep(10000); //wait and try once more, the connection may restore...
        LicenseIsValid(AIncrementUsesCount, false);
      end;
      if e.Message.Contains('Error sending data: (12007)') then
        fMessage := 'Please make sure you have an active internet connection and restart the application' 
      else
        fMessage := e.ClassName+': '+e.Message;
    end;
  end;
end;

procedure TLicenseValidator.AddKeyToRegistry;
begin
  with TRegistry.Create do begin
    try
      try
        RootKey := HKEY_CURRENT_USER;
        if not OpenKey(cRegKey, true) then
          RaiseLastOSError
        else
          WriteString(cLicenseKeyReg, fLicenseKey);
      except
        on e: exception do
          fMessage := e.ClassName+': '+e.Message;
      end;
    finally
      Free;
    end;
  end;
end;

function TLicenseValidator.GetLicenseKey: string;
begin
  result := '';
  with TRegistry.Create do begin
    try
      try
        RootKey := HKEY_CURRENT_USER;
        if not OpenKey(cRegKey, false) then
          RaiseLastOSError
        else
          result := ReadString(cLicenseKeyReg);
      except
        on e: exception do
          fMessage := e.ClassName+': '+e.Message;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TLicenseValidator.DeleteLicense;
begin
  fLicenseKey := '';
  AddKeyToRegistry;
  fMessage := 'License deleted';
end;

end.


