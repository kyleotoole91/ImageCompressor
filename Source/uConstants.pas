unit uConstants;

interface

const
  cSplashBGColor = 5209163;

  cScaleBelowQuality = 25;
  cMinQuality = 1;
  cMaxQuality = 100;
  cDefaultQuality = 50;
  cTargetInterval = 5;
  cBytesToKB = 1024;
  cDefaultMaxWidth = 2560;
  cDefaultMaxHeight = 1920;

  cUTCZone = '?timeZone=UTC';
  cTimeAPIURL = 'https://timeapi.io/api/Time/current/zone';
  cGumRoadLicenseURL = 'https://api.gumroad.com/v2/licenses/verify';
  cGumRoadPerma = 'TICWS';
  cGumRoadPermaParam = 'product_permalink';
  cGumRoadKeyParam = 'license_key';
  cRegKey = 'Software\EireWare\TurboImageCompressor';
  cGumRoadTokenParam = 'access_token';
  cGumRoadIncUsesCount = 'increment_uses_count';
  cLicenseKeyReg = 'LicenseKey';
  cLastMessageVersion = 'LastMessageVersion';
  cUses = 'uses';
  cMessage = 'message';
  {$IFDEF DEBUG}
  cMaxUses = 10;
  {$ELSE}
  cMaxUses = 3;
  {$ENDIF}

  oversizeAllowance=75;
  cPayPalDonateLink = 'https://www.paypal.me/TurboImageCompressor';
  cGumRoadLink = 'https://eireware.gumroad.com/l/TICWS';
  cActivatedCaption = 'Turbo Image Compressor - Pro';
  cEvaluationCaption = 'Turbo Image Compressor';
  cContactVersionURL = 'https://eireware.com/contact';
  cLatestVersionURL = 'https://orcaireland.com/software/TurboImageCompressor_Setup.exe';
  cVersionFile = 'https://orcaireland.com/software/version.json';

implementation

end.
