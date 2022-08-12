unit uConstants;

interface

const
  cDefaultThumbnailMaxSizePx=160;
  cThumbnailSuffix='_thumbnail';
  //uFrmShellScript
  cShellOutputPathVar='[OUTPUT_DIR]';
  cShellPrefixVar='[SOURCE_PREFIX]';
  cShellScript='deployment.bat';
  cShellTestScript='test.bat';
  cShellTempScript='temp.bat';
  //frmMain
  cMinOriginalWidth=1; //min width when using splitter
  cMinFilesWidth=1;
  cDefaultTitle='';
  cDefaultDescription='';
  cDefaultTargetKB=0;
  cDefaultClientWidth=1522;
  cDefaultClientHeight=800;
  cDefaultFilesWidth=185;
  cDefaultImageSplitPause=784;
  cDefaultOriginalWidth=375;
  cDefaultPnlScriptHeight=543;
  cDefaultPnlFilesWidth=247;
  //Responsiveness
  cFirstFlowChangePx=(cDefaultClientWidth-4);
  cSecondFlowChangePx=1142;
  cThirdFlowChangePx=766;
  //json tags
  cOutputDir='outputDir';
  cPrefix='prefix';
  cDefaultOutDir='Compressed';
  cDefaultSourcePrefix = 'images/';
  cJPAllExt='*.jp*';
  cJpgExt='*.jpg';
  cJpegExt='*.jpeg';
  cSettingsFilename='settings.json';
  cJSONFilename='images.json';
  previewMinWidth=530;
  origMinWidth=400;
  oversizeAllowance=75;
  //frmSplash
  cSplashBGColor = 5209163;
  //uJPEGCompressor
  cScaleBelowQuality = 25;
  cMinQuality = 1;
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
  cMsgUnableToFind='Unable to find the selected image';

  cMsgPleaseSelect='Please select an image to open';

  {cMsgNoImagesFound='No images found in the default source directory. '+sLineBreak+sLineBreak+
                    'Please drag and drop images or folders to build a compression queue.'+sLineBreak+sLineBreak+
                    'Alternatively, use the File menu.';}

  cUnSupportedClassType='Unsupported class type';

  cRestoreDefaultsMessage='Are you sure you want to restore default settings?';

  cRestoreDefaultsMessage2=sLineBreak+sLineBreak+'Save Current Settings is needed for this to take effect on the next startup.';

  cDeployScriptEval='Deployment batch scripts are only available in the Pro version.';

  cDeepScanEval='Deep scan is only available in the Pro version.';

  cLinkToBuyMessage='Would you like to be directed to our web page to purchase the Pro version now?';

  cBatchProcessEvaluation='Please select at least one image to process.';

  cReplaceOrigEval='• Replacing original files is only available in the Pro version.';

  cBatchProcessingEval='• Batch processing is only available in the Pro version.';

  cTargetEval='• Target file size is only available in the Pro version.';

  cResamplingEval='• Best resampling is only available in the Pro version.';

  cScriptEval = 'Deployment scripts are only available in the Pro version.';

  cRotationEval='Rotation is only available in the Pro version.';

  cMsgShellScriptWelcome = 'Use this feature to create a deployment script (.bat). '+sLineBreak+sLineBreak+
                           'This script can be set to run after the compression queue has completed. '+sLineBreak+sLineBreak+
                           'This is usefull for deploying the compressed images to a website (eg FTP/SCP/SSH).'+sLineBreak+sLineBreak+
                           'Tip: Use SHH Keys so you can connect to your server(s) without needing to enter a password.';

  cMsgScanningDisk = 'Scanning disk, please wait...';

  cMsgClosingApp = 'Are you sure you want to close this application?';
  cMsgSaveSettings = 'The current settings have been saved.'+sLineBreak+sLineBreak+
                     'They will be used as your default settings and restored on the next startup.';

  cMsgDeploymentWarning='You are configured to run the deployment script after the compression queue has finished.'+sLineBreak+sLineBreak+
                        'Are you sure you want to run the deployment script? ';

  cMsgClearList='Do you want to clear the current image list?';

  cMsgCheckingLicense='Checking license, please wait...';

  cMsgLicenseNotValid='Your license key could not be validated.';

  cMsgLicenseCouldNotValidate='Your license key could not be validated.'+sLineBreak+
                              'The free version of the application will now launch. '+sLineBreak+sLineBreak+
                              'Error returned:';

  cStartingProVersion='Starting Free version..';

  cStartingFreeVersion='Starting Free version..';

  cMsgNewerVersionAvailble='There is a newer version of this software (%s)'+sLineBreak+sLineBreak+
                           'Would you like to download it now? ';

  cMsgReplaceOriginalsScriptWarning = 'Replacing originals will disable the running of the deployment script. '+sLineBreak+sLineBreak+
                                      'Would you like to continue?';

  cMsgScriptWillNotRun='The deployment script will not run while replacing originals is enabled.';

  cMsgPathNotFound='Path not found';

implementation

end.
