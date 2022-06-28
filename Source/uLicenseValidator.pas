unit uLicenseValidator;

interface

uses
  System.Net.HttpClient, System.Classes, SuperObject;

type
  TLicenseValidator = class(TObject)
  strict private
    fResp: IHTTPResponse;
    fJSON: ISuperObject;
    fMessage: string;
    fLicenseKey: string;
    fHTTP: THTTPClient;
    fParams: TStringList;
    fNowDate: TDateTime;
    procedure AddKeyToRegistry;
    function GetNowDate: TDateTime;
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

uses
  uConstants, System.Win.Registry, Winapi.Windows, System.SysUtils, DateUtils;

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
  try
    {$IFDEF DEBUG}
    result := true;
    Exit;
    {$ELSE}
    result := false;
    {$ENDIF}
    fNowDate := 0;
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
      if (fJSON.B['success']) and
         (fResp.StatusCode = 200) and
         (Assigned(fJSON.O['purchase'])) then begin
        with fJSON.O['purchase'] do begin
          if B['refunded'] or B['chargebacked'] then
            fMessage := 'This key is no longer valid, you have been refuded for this product'
          else if B['disputed'] or B['dispute_won'] then
            fMessage := 'This key is not currently valid due to a dispute'
          else if (S['subscription_id'] <> '') and
                  ((S['subscription_failed_at'] <> '') and
                   (ISO8601ToDate(S['subscription_failed_at']) <= Now)) then
            fMessage := 'Your subscription payment has failed, please check your payment method. The free version will now start. '
          else if (S['subscription_id'] <> '') and
                  (((S['subscription_ended_at'] <> '') and (ISO8601ToDate(S['subscription_ended_at']) <= GetNowDate)) or
                   ((S['subscription_cancelled_at'] <> '') and (ISO8601ToDate(S['subscription_cancelled_at']) <= GetNowDate))) then begin
            DeleteLicense;
            fMessage := 'Your subscription has ended. ';
          end else
            result := true;
        end;
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

function TLicenseValidator.GetNowDate: TDateTime;
var
  json: ISuperObject;
begin
  try
    if fNowDate = 0 then begin
      try
        json := SO(fHTTP.Get(cTimeAPIURL+cUTCZone).ContentAsString);
        if (Assigned(json)) and
           (json.S['dateTime'] <> '') then
          fNowDate := ISO8601ToDate(json.S['dateTime'])
      except
      end;
    end;
  finally
    if fNowDate = 0 then
      fNowDate := Now; //default to system date (if this API ever goes down)
    result := fNowDate;
    json := nil;
  end;
end;

procedure TLicenseValidator.DeleteLicense;
begin
  fLicenseKey := '';
  AddKeyToRegistry;
  fMessage := 'License deleted';
end;

end.


