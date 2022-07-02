unit uSecrets;

interface

implementation

{
//cGumRoadAccessToken='T_3Bc-K8h1Brc9n2n7ZHxwcAjMD9vi6Sayn9PHs8Lu8';
//cGumRoadDecrementURL = 'https://api.gumroad.com/v2/licenses/decrement_uses_count';
procedure DecrementUsesCount;
procedure uLicenseValidator.TLicenseValidator.DecrementUsesCount;
begin
  try
    if fLicenseKey = '' then
      fLicenseKey := GetLicenseKey;
    fMessage := '';
    fParams.Clear;
    fParams.Add(cGumRoadTokenParam+'='+cGumRoadAccessToken);
    fParams.Add(cGumRoadPermaParam+'='+cGumRoadPerma);
    fParams.Add(cGumRoadKeyParam+'='+fLicenseKey);
    fResp := fHTTP.Put(cGumRoadDecrementURL, fParams);
  except
    on e: exception do
      fMessage := e.ClassName+': '+e.Message;
  end;
end;}

end.
