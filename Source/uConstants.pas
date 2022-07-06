unit uConstants;

interface

const
  //uFrmShellScript
  cShellOutputPathVar='[OUTPUT_DIR]';
  cShellPrefixVar='[SOURCE_PREFIX]';
  cShellScript='deployment.bat';
  cShellTestScript='test.bat';
  cShellTempScript='temp.bat';
  //frmMain
  cOutputDir='outputDir';
  cPrefix='prefix';
  cDefaultOutDir='Compressed';
  cDefaultSourcePrefix = 'images/';
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
  cMsgShellScriptWelcome = 'Use this feature to create and run .bat file. '+sLineBreak+sLineBreak+
                           'This script can be set to run after the compression queue has completed. '+sLineBreak+sLineBreak+
                           'This is usefull for deploying the compressed images to a website (eg SCP).'+sLineBreak+sLineBreak+
                           'NB: OpensSSH programs such as scp.exe may need to be copied or moved to a directory that has read permissions. '+
                           'Configuring PATH environment variables is recommended.';
  cMsgScanningDisk = 'Scanning disk, please wait...';
  cMsgClosingApp = 'Are you sure you want to close this application?';

implementation

end.
