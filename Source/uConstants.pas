unit uConstants;

interface

const
  cShellScript='deployment.bat';
  cShellTestScript='test.bat';
  //frmMain
  cDefaultOutDir='Compressed\';
  cJPAllExt='*.jp*';
  cJpgExt='*.jpg';
  cJpegExt='*.jpeg';
  cSettingsFilename='settings.json';
  previewMinWidth=530;
  origMinWidth=400;
  oversizeAllowance=75;
  //frmSplash
  cSplashBGColor = 5209163;
  //uJPEGCompressor
  cScaleBelowQuality = 25;
  cMinQuality = 1;  //allow user pick 1
  cMaxQuality = 100;
  cDefaultQuality = 80;
  cTargetInterval = 5;
  cBytesToKB = 1024;
  cDefaultMaxWidth = 2560;
  cDefaultMaxHeight = 1920;
  //uLicenseValidator
  cUTCZone = '?timeZone=UTC';
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
  //third parties
  cTimeAPIURL = 'https://timeapi.io/api/Time/current/zone';
  cGumRoadLicenseURL = 'https://api.gumroad.com/v2/licenses/verify';
  cPayPalDonateLink = 'https://www.paypal.me/TurboImageCompressor';
  cGumRoadLink = 'https://eireware.gumroad.com/l/TICWS';
  cActivatedCaption = 'Turbo Image Compressor - Pro';
  cEvaluationCaption = 'Turbo Image Compressor';
  cContactVersionURL = 'https://eireware.com/contact';
  //affiliate
  cLatestVersionURL = 'https://orcaireland.com/software/TurboImageCompressor_Setup.exe';
  cVersionFile = 'https://orcaireland.com/software/version.json';
  //messages
  cDeployScriptEval='Deployment batch scripts are only available in the Pro version.';
  cDeepScanEval='Deep scan is only available in the Pro version.';
  cLinkToBuyMessage='Would you like to be directed to our web page to purchase the Pro version now?';
  cBatchProcessEvaluation='Please select at least one image to process.';
  cReplaceOrigEval='• Replacing original files is only available in the Pro version.';
  cBatchProcessingEval='• Batch processing is only available in the Pro version.';
  cTargetEval='• Target file size is only available in the Pro version.';
  cResamplingEval='• Best resampling is only available in the Pro version';
  cMsgShellScriptWelcome = 'Use this feature to create a .bat file. '+sLineBreak+sLineBreak+
                           'This CMD script will run after the compression queue has completed. '+sLineBreak+sLineBreak+
                           'This may be used to deploy images to a website.';
  cMsgScanningDisk = 'Scanning disk, please wait...';
  cMsgClosingApp = 'Are you sure you want to close this application?';

implementation

end.
