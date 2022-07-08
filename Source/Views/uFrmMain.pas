unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, uJPEGCompressor,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Samples.Spin, SuperObject, Vcl.ComCtrls, Vcl.Menus,
  Vcl.CheckLst, System.IOUtils, System.Types, System.UITypes, DateUtils, ShellApi, DosCommand, uFormData,
  Vcl.Buttons, Generics.Collections, Img32.Panels, uImageConfig, uLicenseValidator, uConstants, uScriptVariables, uMainController;

type
  TFrmMain = class(TForm)
    pcMain: TPageControl;
    tsHome: TTabSheet;
    tsLogs: TTabSheet;
    pnlMain: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnStart: TButton;
    Label3: TLabel;
    btnScan: TButton;
    pmCheckBoxList: TPopupMenu;
    mniUnSelectAll: TMenuItem;
    mniSelectAll: TMenuItem;
    pnlConfig: TPanel;
    GroupBox1: TGroupBox;
    lbQuality: TLabel;
    seQuality: TSpinEdit;
    cbCompress: TCheckBox;
    GroupBox3: TGroupBox;
    lbMaxHeightPx: TLabel;
    lbMaxWidthPx: TLabel;
    rbByHeight: TRadioButton;
    rbByWidth: TRadioButton;
    ebStartPath: TEdit;
    ebOutputDir: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    cbApplyGraphics: TCheckBox;
    pnlFiles: TPanel;
    lbFiles: TLabel;
    cblFiles: TCheckListBox;
    pnlImage: TPanel;
    imgHome: TImage;
    Splitter1: TSplitter;
    miClear: TMenuItem;
    pmResults: TPopupMenu;
    lbTargetKB: TLabel;
    seTargetKBs: TSpinEdit;
    lbImage: TLabel;
    cbCompressPreview: TCheckBox;
    lbImgSizeKB: TLabel;
    lbImgSizeKBVal: TLabel;
    lbImgWidth: TLabel;
    lbImgWidthVal: TLabel;
    lbImgHeight: TLabel;
    lbImgHeightVal: TLabel;
    mmMenu: TMainMenu;
    File1: TMenuItem;
    mmiOpenFolder: TMenuItem;
    mmiOpen: TMenuItem;
    cbStretch: TCheckBox;
    View1: TMenuItem;
    miHideConfig: TMenuItem;
    seMaxWidthPx: TSpinEdit;
    seMaxHeightPx: TSpinEdit;
    miHideFiles: TMenuItem;
    GroupBox4: TGroupBox;
    GroupBox2: TGroupBox;
    lbPrefix: TLabel;
    lbDescription: TLabel;
    ebPrefix: TEdit;
    ebDescription: TEdit;
    cbIncludeInJSONFile: TCheckBox;
    cbApplyToAll: TCheckBox;
    btnApply: TButton;
    ebFilename: TEdit;
    lbFilename: TLabel;
    N1: TMenuItem;
    Refresh1: TMenuItem;
    tbQuality: TTrackBar;
    cbResampleMode: TComboBox;
    cbRotateAmount: TComboBox;
    lbResampling: TLabel;
    lbRotation: TLabel;
    pnlOriginal: TPanel;
    imgOriginal: TImage;
    Label4: TLabel;
    lbImgOrigSizeKBVal: TLabel;
    lbImgOrigWidth: TLabel;
    lbImgOrigWidthVal: TLabel;
    lbImgOrigHeight: TLabel;
    lbImgOrigHeightVal: TLabel;
    spOriginal: TSplitter;
    lbImgOrigSize: TLabel;
    miHideOriginal: TMenuItem;
    miApplyBestFit: TMenuItem;
    cbStretchOriginal: TCheckBox;
    miUpgrade: TMenuItem;
    miPurchaseLicense: TMenuItem;
    miEnterLicense: TMenuItem;
    miFullscreen: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    miRefresh: TMenuItem;
    pmViews: TPopupMenu;
    miSplit: TMenuItem;
    miHideOriginalPm: TMenuItem;
    miHideImageList: TMenuItem;
    N4: TMenuItem;
    Filter1: TMenuItem;
    miFilesSizeFilter: TMenuItem;
    N5: TMenuItem;
    Hide1: TMenuItem;
    miImgFullscreen: TMenuItem;
    CloseApplication1: TMenuItem;
    N6: TMenuItem;
    Help1: TMenuItem;
    miDownload: TMenuItem;
    miContact: TMenuItem;
    Settings1: TMenuItem;
    miDeepScan: TMenuItem;
    miReplaceOriginals: TMenuItem;
    miClearFiles: TMenuItem;
    miSaveSettings: TMenuItem;
    miAdvanced: TMenuItem;
    DeploymentScript1: TMenuItem;
    miSelectOutputDir: TMenuItem;
    tmrOnShow: TTimer;
    miAutoPrefix: TMenuItem;
    miRestoreDefaults: TMenuItem;
    N7: TMenuItem;
    spScript: TSplitter;
    pnlLogs: TPanel;
    Panel1: TPanel;
    mmMessages: TMemo;
    pnlScript: TPanel;
    Panel4: TPanel;
    mmScript: TMemo;
    procedure btnStartClick(Sender: TObject);
    procedure seTargetKBsChange(Sender: TObject);
    procedure cbCompressClick(Sender: TObject);
    procedure cbIncludeInJSONFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckStartOk(Sender: TObject);
    procedure SetShrinkState(Sender: TObject);
    procedure miClearClick(Sender: TObject);
    procedure btnScanClick(Sender: TObject);
    procedure cblFilesClickCheck(Sender: TObject);
    procedure mniUnSelectAllClick(Sender: TObject);
    procedure mniSelectAllClick(Sender: TObject);
    procedure cblFilesClick(Sender: TObject);
    procedure CheckCompressPreviewLoad(Sender: TObject);
    procedure seMaxWidthPxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seMaxHeightPxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seTargetKBsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seQualityKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ShowFolderSelect(Sender: TObject);
    procedure ShowFileSelect(Sender: TObject);
    procedure cbStretchClick(Sender: TObject);
    procedure miHideConfigClick(Sender: TObject);
    procedure miHideFilesClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure Refresh1Click(Sender: TObject);
    procedure ebPrefixChange(Sender: TObject);
    procedure ebDescriptionChange(Sender: TObject);
    procedure tbQualityChange(Sender: TObject);
    procedure tbQualityKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seQualityExit(Sender: TObject);
    procedure cbResampleModeExit(Sender: TObject);
    procedure cbRotateAmountExit(Sender: TObject);
    procedure cbRotateAmountKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbResampleModeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbResampleModeChange(Sender: TObject);
    procedure cbStretchOriginalClick(Sender: TObject);
    procedure miShowOriginalClick(Sender: TObject);
    procedure cbApplyGraphicsClick(Sender: TObject);
    procedure spOriginalMoved(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miApplyBestFitClick(Sender: TObject);
    procedure miPurchaseLicenseClick(Sender: TObject);
    procedure miHideOriginalClick(Sender: TObject);
    procedure miEnterLicenseClick(Sender: TObject);
    procedure LoadCompressedPreview(Sender: TObject);
    procedure ResizeEvent(Sender: TObject);
    procedure Scan(Sender: TObject);
    procedure miFullscreenClick(Sender: TObject);
    procedure tmrResizeTimer(Sender: TObject);
    procedure miRefreshClick(Sender: TObject);
    procedure miHideOriginalPmClick(Sender: TObject);
    procedure pmViewsPopup(Sender: TObject);
    procedure miSplitClick(Sender: TObject);
    procedure miHideImageListClick(Sender: TObject);
    procedure miFilesSizeFilterClick(Sender: TObject);
    procedure CloseApplication1Click(Sender: TObject);
    procedure miDownloadClick(Sender: TObject);
    procedure miContactClick(Sender: TObject);
    procedure miDeepScanClick(Sender: TObject);
    procedure miReplaceOriginalsClick(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure ebStartPathKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure miClearFilesClick(Sender: TObject);
    procedure miSaveSettingsClick(Sender: TObject);
    procedure DeploymentScript1Click(Sender: TObject);
    procedure miSelectOutputDirClick(Sender: TObject);
    procedure ebStartPathEnter(Sender: TObject);
    procedure tmrOnShowTimer(Sender: TObject);
    procedure ebOutputDirChange(Sender: TObject);
    procedure miAutoPrefixClick(Sender: TObject);
    procedure miRestoreDefaultsClick(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
  public
    { Private declarations }
    fRunScript: boolean;
    fDirectoryScanned,
    fDrapAndDropping,
    fEvaluationMode,
    fImageChanged: boolean;
    fFormOpenClose,
    fLoadingPreview: boolean;
    fFilterSizeKB: uInt64;
    fJSON: ISuperObject;
    fWorkingDir: string;
    fFilename: string;
    fNumProcessed: integer;
    fMessages: TStringList;
    fOutputDir: string;
    fStartTime,
    fEndTime: TDateTime;
    fTotalSavedKB: Int64;
    fLoading: boolean;
    fLicenseValidator: TLicenseValidator;
    fFormCreating: boolean;
    fSelectedFilename: string;
    fJPEGCompressor: TJPEGCompressor;
    fImageConfig: TImageConfig;
    fFilenameList: TStringList;
    fMainController: TMainController;
    procedure SetPrefixDir(const AOutputPath: string);
    function GetSelectedFileName: string;
    function SelectedFileCount: integer;
    procedure CheckHideLabels;
    procedure SetControlState(const AEnabled: boolean);
    procedure SetChildControlES(const AParentControl: TControl; const AEnabled: Boolean);
    procedure SetEvaluationMode(const Value: boolean);
    procedure AcceptFiles(var AMsg: TMessage); message WM_DROPFILES;
    { Public declarations }
    property EvaluationMode: boolean read fEvaluationMode write SetEvaluationMode;
  end; 
  
var
  FrmMain: TFrmMain;

implementation

uses
  uDlgFilter, uDlgProgress, REST.JSON, uFrmShellScript;

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  inherited;
  fRunScript := false;
  DragAcceptFiles(Self.Handle, true);
  fFilenameList := TStringList.Create;
  fDirectoryScanned := true;
  fDrapAndDropping := false;
  fFilterSizeKB := 0;
  fImageChanged := true;
  fFormCreating := true;
  fLoadingPreview := false;
  fJPEGCompressor := TJPEGCompressor.Create;
  fEvaluationMode := true;
  fLicenseValidator := TLicenseValidator.Create;
  fMessages := TStringList.Create;
  fFormOpenClose := false;
  fLoading := false;
  seTargetKBs.Value := 0;
  tbQuality.Min := cMinQuality;
  tbQuality.Max := cMaxQuality;
  seQuality.MaxValue := cMaxQuality;
  seQuality.MinValue := cMinQuality;
  seQuality.Value := cMaxQuality;
  seMaxWidthPx.Value := cDefaultMaxWidth;
  seMaxHeightPx.Value := cDefaultMaxHeight;
  fWorkingDir := TPath.GetPicturesPath;
  fOutputDir := IncludeTrailingPathDelimiter(fWorkingDir)+cDefaultOutDir;
  ebOutputDir.Text := fOutputDir;
  pcMain.ActivePage := tsHome;
  ClientWidth := 1820;
  ClientHeight := 950;
  spOriginal.Left := 784;
  tmrOnShow.Enabled := false;
  fMainController := TMainController.Create(Self);
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  try
    try
      fFilenameList.Free;
      fMessages.Free;
      fJPEGCompressor.Free;
      fLicenseValidator.Free;
      fMainController.ClearConfigList;
      fMainController.Free;
    except
    end;
  finally
    inherited;
  end;
end;

procedure TFrmMain.miFilesSizeFilterClick(Sender: TObject);
begin
  DlgFilter := TDlgFilter.Create(Self);
  try
    DlgFilter.Size := fFilterSizeKB;
    DlgFilter.ShowModal;
    if DlgFilter.RecordModified then begin
      fFilterSizeKB := DlgFilter.Size;
      Scan(Sender);
    end;
  finally
    DlgFilter.Free;
  end;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fFormOpenClose := true;
  DragAcceptFiles(Self.Handle, false);
  inherited;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;
  try
    fFormOpenClose := true;
    mmMessages.Clear;
    pcMain.ActivePage := tsHome;
    ebStartPath.Text := fWorkingDir;
    fFormCreating := false;
  finally
    Screen.Cursor := crDefault;
    fMainController.LoadFormSettings;
    Scan(Sender);
    fFormOpenClose := false;
    mmMessages.Lines.Clear;
    if fSelectedFilename = '' then
      tmrOnShow.Enabled := true;
  end;
end;

procedure TFrmMain.LoadCompressedPreview(Sender: TObject);
var
  stretch: boolean;
  imageConfig: TImageConfig;
begin
  if cbCompress.Checked or
     cbApplyGraphics.Checked then begin
    Screen.Cursor := crHourGlass;
    fLoadingPreview := true;
    stretch := cbStretch.Checked;
    imageConfig := TImageConfig.Create;
    try
      fMainController.FormToObj(imageConfig);
      if (fImageConfig.PreviewModified) or
         (fJPEGCompressor.SourceFilename <> fSelectedFilename) then begin
        fJPEGCompressor.OutputDir := ebOutputDir.Text;
        fJPEGCompressor.Compress := imageConfig.Compress;
        fJPEGCompressor.ApplyGraphics := imageConfig.ApplyGraphics;
        fJPEGCompressor.CompressionQuality := imageConfig.Quality;
        fJPEGCompressor.TargetKB := imageConfig.TargetKB;
        fJPEGCompressor.ShrinkByHeight := not imageConfig.ShrinkByWidth;
        fJPEGCompressor.ShrinkByMaxPx := imageConfig.ShrinkByValue;
        fJPEGCompressor.ResampleMode := imageConfig.ResampleMode;
        fJPEGCompressor.RotateAmount := imageConfig.RotateAmount;
        fJPEGCompressor.Process(fSelectedFilename, false);
        fImageConfig.PreviewModified := false;
      end else if (not fImageConfig.PreviewModified) then begin
        fJPEGCompressor.MemoryStream.Position := 0;
        fJPEGCompressor.JPEG.LoadFromStream(fJPEGCompressor.MemoryStream);
      end;
    finally
      cbStretch.Checked := false;
      fMainController.LoadImage(fJPEGCompressor.JPEG, imgHome);
      lbImgSizeKBVal.Caption := fJPEGCompressor.CompressedFilesize.ToString;
      lbImgWidthVal.Caption := fJPEGCompressor.ImageWidth.ToString;
      lbImgHeightVal.Caption := fJPEGCompressor.ImageHeight.ToString;
      if (Sender <> seQuality) and
         (Sender <> tbQuality) then begin
        seQuality.Value := fJPEGCompressor.JPEG.CompressionQuality;
        tbQuality.Position := seQuality.Value;
      end;
      cbStretch.Checked := stretch;
      Screen.Cursor := crDefault;
      fLoadingPreview := false;
      imageConfig.Free;
    end;
  end;
end;

{ If DevExpress is installed, force the use of TdxSmartImage Graphic. This results in better image quality at all scales
  of large images that get squashed into the TImage control. Using this, removes the need for the LoadImage() method.
procedure TFrmMain.LoadImagePreview(const AMS: TMemoryStream);
var
  AGraphic: TdxSmartImage;
begin
  AGraphic := TdxSmartImage.Create;
  try
    AMS.Position := 0;
    imgHome.Picture.Graphic := AGraphic;
    imgHome.Picture.Graphic.LoadFromStream(AMS);
  finally
    AGraphic.Free;
  end;
end;}

procedure TFrmMain.mniSelectAllClick(Sender: TObject);
var
  a: integer;
begin
  for a := 0 to cblFiles.Count-1 do
    cblFiles.Checked[a] := true;
  btnStart.Enabled := (cblFiles.Count > 0) and (cbIncludeInJSONFile.Checked or cbCompress.Checked or cbApplyGraphics.Checked);
end;

procedure TFrmMain.mniUnSelectAllClick(Sender: TObject);
var
  a: integer;
begin
  for a := 0 to cblFiles.Count-1 do
    cblFiles.Checked[a] := false;
  btnStart.Enabled := false;
end;

procedure TFrmMain.miHideConfigClick(Sender: TObject);
begin
  pnlConfig.Visible := not pnlConfig.Visible;
  miHideConfig.Checked := not pnlConfig.Visible;
end;

procedure TFrmMain.miClearClick(Sender: TObject);
begin
  mmMessages.Lines.BeginUpdate;
  try
    mmMessages.Clear;
    mmMessages.Lines.Clear;
  finally
    mmMessages.Lines.EndUpdate;
  end;
end;

procedure TFrmMain.miContactClick(Sender: TObject);
begin
  fMainController.OpenURL(cContactVersionURL);
end;

procedure TFrmMain.miDeepScanClick(Sender: TObject);
begin
  if fEvaluationMode then begin
    if MessageDlg(cDeepScanEval+sLineBreak+sLineBreak+cLinkToBuyMessage, mtWarning, mbOKCancel, 0) = mrOk then
      fMainController.OpenURL(cGumRoadLink);
  end else begin
    miDeepScan.Checked := not miDeepScan.Checked;
    fMainController.FormData.DeepScan := miDeepScan.Checked;
    Scan(Sender);
  end;
end;

procedure TFrmMain.miDownloadClick(Sender: TObject);
begin
  fMainController.OpenURL(cLatestVersionURL);
end;

procedure TFrmMain.miEnterLicenseClick(Sender: TObject);
var
  newKey, currentKey, msg: string;
  isValid, userCleared: boolean;
begin
  msg := '';
  Screen.Cursor := crHourGlass;
  try
    currentKey := fLicenseValidator.GetLicenseKey;
  finally
    Screen.Cursor := crDefault;
  end;
  newKey := InputBox('Enter License Key', 'Key:', currentKey);
  if newKey <> currentKey then begin
    Screen.Cursor := crHourGlass;
    try
      userCleared := (currentKey <> '') and (newKey = '');
      if userCleared then begin
        fLicenseValidator.DeleteLicense;
        EvaluationMode := true;
      end else begin
        fLicenseValidator.LicenseKey := newKey;
        if fLicenseValidator.LicenseKey <> '' then begin
          isValid := fLicenseValidator.LicenseIsValid;
          if EvaluationMode then
            EvaluationMode := not isValid;
        end;
      end;
    finally
      Screen.Cursor := crDefault;
      if (msg <> '') and fEvaluationMode then
        MessageDlg(msg, TMsgDlgType.mtError, [mbOk], 0)
      else if fLicenseValidator.Message <> '' then
        MessageDlg(fLicenseValidator.Message, TMsgDlgType.mtInformation, [mbOk], 0);
    end;
  end;
end;

procedure TFrmMain.miFullscreenClick(Sender: TObject);
begin
  miFullscreen.Checked := not miFullscreen.Checked;
  miImgFullscreen.Checked := miFullscreen.Checked;
  miHideConfig.Checked := miFullscreen.Checked;
  miHideFiles.Checked := miFullscreen.Checked;
  miHideOriginal.Checked := miFullscreen.Checked;
  pnlFiles.Visible := not miFullscreen.Checked;
  pnlOriginal.Visible := not miFullscreen.Checked;
  spOriginal.Visible := not miFullscreen.Checked;
  pnlConfig.Visible := not miFullscreen.Checked;
  ResizeEvent(Sender);
end;

procedure TFrmMain.AcceptFiles(var AMsg: TMessage);
const
  cnMaxCharArrayLen = 255;
var
  a,
  errCount: integer;
  fileCount: integer;
  filename: string;
  selectedIndex: integer;
  filenames: TStringDynArray;
  caFilename: array [0..cnMaxCharArrayLen] of char;
  function Validate(const AFilename: string): string;
  var
    lowerStr: string;
  const
    eos=''#0'';
  begin
    if AFilename.Contains(eos) then
      result := Copy(AFilename, 0, Pos(eos, AFilename)-Length(eos))
    else
      result := AFilename;
    lowerStr := LowerCase(result);
    if lowerStr.Contains('.jpg') then
      result := Copy(AFilename, 0, Pos('.jpg', lowerStr)+Length('.jpg')-1)
    else if lowerStr.Contains('.jpeg') then
      result := Copy(AFilename, 0, Pos('.jpeg', lowerStr)+Length('.jpeg')-1)
    else if ExtractFileExt(result) <> '' then
      result := '';
  end;
  procedure AddFile(const AFilename: string);
  begin
    if AFilename <> '' then begin
      if fFilenameList.IndexOf(AFilename) = -1 then
        fFilenameList.Add(AFilename)
      else
        selectedIndex := fFilenameList.IndexOf(AFilename);
    end;
  end;
begin
  errCount := 0;
  selectedIndex := -1;
  fDrapAndDropping := true;
  try
    fileCount := DragQueryFile(AMsg.WParam, $FFFFFFFF, caFilename, cnMaxCharArrayLen);
    if fDirectoryScanned then begin
      fFilenameList.Clear;
      ebStartPath.Text := '';
      fDirectoryScanned := false;
    end;
    for a := 0 to fileCount-1 do begin
      DragQueryFile(AMsg.WParam, a, caFilename, cnMaxCharArrayLen);
      SetString(filename, PChar(@caFilename[0]), Length(caFilename));
      filename := Validate(filename);
      if filename <> '' then begin
        if ExtractFileExt(filename) <> '' then
          AddFile(filename)
        else begin
          filenames := TDirectory.GetFiles(filename, cJPAllExt, TSearchOption.soAllDirectories);
          for filename in filenames do
            AddFile(Validate(filename));
        end;
      end else
        Inc(errCount);
    end;
    if errCount > 0 then
      MessageDlg(IntToStr(errCount)+ ' unsupported files were not added' , TMsgDlgType.mtError, [mbOk], 0);
    Scan(nil);
    if selectedIndex > -1 then begin
      cblFiles.Selected[selectedIndex] := true;
      fSelectedFilename := cblFiles.Items[selectedIndex];
    end;
    fMainController.LoadSelectedFromFile;
  finally
    fDrapAndDropping := false;
    DragFinish(AMsg.WParam);
  end;
end;

procedure TFrmMain.Scan(Sender: TObject);
var
  a: integer;
  filename: string;
  imageLoaded: boolean;
  badFilenames: TStringList;
begin
  if (not fDrapAndDropping) and
     (Sender <> miClearFiles) then
    fMainController.ScanDisk;
  Screen.Cursor := crHourGlass;
  cblFiles.Items.BeginUpdate;
  badFilenames := TStringList.Create;
  try
    if (fWorkingDir <> ebStartPath.Text) or
       (Sender <> ebStartPath) then begin
      CheckStartOk(Sender);
      fWorkingDir := ebStartPath.Text;
      cblFiles.Items.Clear;
      fMainController.ClearConfigList;
      for filename in fFilenameList do begin
        if (not filename.Contains('!')) and
           (LowerCase(filename).EndsWith('.jpg') or LowerCase(filename).EndsWith('.jpeg')) then begin
          if (fFilterSizeKB <= 0) or
             (fMainController.SizeOfFileKB(filename) >= fFilterSizeKB) then begin
            if fMainController.FormData.DeepScan or fDrapAndDropping then
              cblFiles.Items.Add(filename)
            else
              cblFiles.Items.Add(ExtractFileName(filename));
            cblFiles.Checked[cblFiles.Count-1] := false;
          end;
        end else
          badFilenames.Add(filename);
      end;
      for a:=0 to badFilenames.Count-1 do
        fFilenameList.Delete(fFilenameList.IndexOf(badFilenames.Strings[a]));
      imageLoaded := fMainController.LoadSelectedFromFile;
      cbApplyToAll.Checked := true;
      btnStart.Enabled := false;
      SetControlState(imageLoaded);
    end;
  finally
    badFilenames.Free;
    if cblFiles.Items.Count = 0 then begin
      imgHome.Picture.Assign(nil);
      imgOriginal.Picture.Assign(nil);
    end else begin
      if fDirectoryScanned then
        cblFiles.Selected[0] := true
      else
        cblFiles.Selected[cblFiles.Count-1] := true;
    end;
    mmMessages.Lines.Add(fMessages.Text);
    fMessages.Clear;
    cblFiles.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.miApplyBestFitClick(Sender: TObject);
begin
  miApplyBestFit.Checked := not miApplyBestFit.Checked;
  Screen.Cursor := crHourGlass;
  try
    fMainController.LoadImage(fJPEGCompressor.JPEG, imgHome);
    fMainController.LoadImage(fJPEGCompressor.JPEGOriginal, imgOriginal);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.miAutoPrefixClick(Sender: TObject);
begin
  miAutoPrefix.Checked := not miAutoPrefix.Checked;
  fMainController.FormData.AutoPrefix := miAutoPrefix.Checked;
end;

procedure TFrmMain.btnApplyClick(Sender: TObject);
  procedure SelectCurrentImage;
  var
    a: integer;
    filename: string;
  begin
    for a := 0 to cblFiles.Items.Count-1 do begin
      filename := cblFiles.Items[a];
      if ExtractFilePath(filename) = '' then
        filename := IncludeTrailingPathDelimiter(ebStartPath.Text)+filename;
      if filename = fSelectedFilename then begin
        cblFiles.Selected[a] := true;
        cblFiles.Checked[a] := true;
        Break;
      end;
    end;
  end;
begin
  fMainController.FormToObj;
  SelectCurrentImage;
  if Assigned(fImageConfig) then
    fImageConfig.RecordModified := false;
  cbApplyToAll.Checked := false;
  btnApply.Enabled := false;
end;

procedure TFrmMain.btnScanClick(Sender: TObject);
begin
  Scan(Sender);
end;

procedure TFrmMain.btnStartClick(Sender: TObject);
var
  filename: string;
  startTime: TDateTime;
  dlgProgrss: TDlgProgress;
  runScript: boolean;
  replacingOriginals: boolean;
begin
  fJSON := TSuperObject.Create(stArray);
  btnStart.Enabled := false;
  startTime := Now;
  runScript := fRunScript;
  try
    replacingOriginals := fMainController.FormData.ReplaceOriginals or (ExtractFilePath(ebStartPath.Text) = ExtractFilePath(ebOutputDir.Text));
    if ((not replacingOriginals) or
       (mrYes = MessageDlg('Outputing to the source directory will result in the original .jpg(s) becoming overwritten.'+#13+#10+
                           'Are you sure you want to overwrite the original images? ', mtWarning, [mbYes, mbNo], 0))) and
        fMainController.ValidSelection(Sender) then begin
      if runScript and
        (mrYes <> MessageDlg('You are configured to run the deployment script after the compression queue has finished.'+sLineBreak+sLineBreak+
                             'Are you sure you want to run the deployment script? ', mtWarning, [mbYes, mbNo], 0)) then
        runScript := false;
      Screen.Cursor := crHourGlass;
      dlgProgrss := TDlgProgress.Create(Self);
      try
        dlgProgrss.Show;
        Application.ProcessMessages;
        fOutputDir := IncludeTrailingPathDelimiter(ebOutputDir.Text);
        fTotalSavedKB := 0;
        fNumProcessed := 0;
        mmMessages.Lines.BeginUpdate;
        fMessages.Add('--------------------- Start ---------------------------');
        filename := ebStartPath.Text;
        if LowerCase(ExtractFileExt(filename)) = '.jpg' then
          fMainController.ProcessFile(filename)
        else begin
          for filename in fFilenameList do begin
            if fMainController.FormData.DeepScan or (not fDirectoryScanned) then begin
              if (cblFiles.Items.IndexOf(filename) >= 0) and
                 (cblFiles.Checked[cblFiles.Items.IndexOf(filename)]) then
                fMainController.ProcessFile(filename);
            end else begin
              if (cblFiles.Items.IndexOf(ExtractFileName(filename)) >= 0) and
                 (cblFiles.Checked[cblFiles.Items.IndexOf(ExtractFileName(filename))]) then
                fMainController.ProcessFile(filename);
            end;
          end;
        end;
        if cbIncludeInJSONFile.Checked then
          fMainController.CreateJSONFile(fJSON);
        if runScript then
          fMainController.RunDeploymentScript;
      finally
        dlgProgrss.Free;
        if fNumProcessed = 0 then
          MessageDlg('No .jpg files processed', mtWarning, [mbOK], 0)
        else if (cbApplyGraphics.Checked or cbCompress.Checked) then begin
          fMessages.Add('Finished processing '+fNumProcessed.ToString+' .jpg files. ');
          fMessages.Add('Total saved (KB): '+fTotalSavedKB.ToString);
          MessageDlg('Finished processing '+fNumProcessed.ToString+' .jpg files. '+sLineBreak+
                     'Total saved (KB): '+fTotalSavedKB.ToString+sLineBreak+
                     'Total duration (s): '+SecondsBetween(startTime, Now).ToString, mtInformation, [mbOK], 0);
        end else begin
          fMessages.Add('Finished processing '+fNumProcessed.ToString+' .jpg files. ');
          MessageDlg('Finished processing '+fNumProcessed.ToString+' .jpg files. '+sLineBreak+
                     'Total duration (s): '+SecondsBetween(startTime, Now).ToString, mtInformation, [mbOK], 0);
        end;
        fMessages.Add('Total duration (s) '+SecondsBetween(startTime, Now).ToString);
        fMessages.Add('--------------------- End -------------------------');
        mmMessages.Lines.Add(fMessages.Text);
        mmMessages.Lines.EndUpdate;
        if fMainController.FormData.ReplaceOriginals then
          fMainController.LoadImagePreview(fSelectedFilename);
        if runScript then begin
          fMainController.ToggleScriptLog;
          pcMain.ActivePage := tsLogs;
        end;
        Screen.Cursor := crDefault;
      end;
    end;
  finally
    fJSON := nil;
    btnStart.Enabled := true;
  end;
end;

procedure TFrmMain.CheckCompressPreviewLoad(Sender: TObject);
begin
  if not fLoading then begin
    Screen.Cursor := crHourGlass;
    try
      if Sender <> cbCompressPreview then
        fImageConfig.PreviewModified := true;
      if (Sender = cbCompressPreview) and (not cbCompressPreview.Checked) then
        fMainController.LoadImage(fJPEGCompressor.JPEGOriginal, imgHome)
      else if cbCompressPreview.Checked then begin
        if cbCompress.Checked or cbApplyGraphics.Checked then
          LoadCompressedPreview(Sender)
        else if Assigned(Sender) and (Sender=cbCompressPreview) or
                ((not cbCompress.Checked) and (not cbApplyGraphics.Checked)) then
          fMainController.LoadImage(fJPEGCompressor.JPEGOriginal, imgHome);
        cbStretch.Enabled := cbCompressPreview.Enabled;
      end;
      if (Sender <> cblFiles) and
         (Sender <> cbCompressPreview) then
        btnApply.Enabled := true;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFrmMain.CheckHideLabels;
begin
  cbStretchOriginal.Visible := false;
  try
    lbImgSizeKB.Visible := pnlImage.Width >= previewMinWidth;
    lbImgSizeKBVal.Visible := pnlImage.Width >= previewMinWidth;
    lbImgWidth.Visible := pnlImage.Width >= previewMinWidth;
    lbImgWidthVal.Visible := pnlImage.Width >= previewMinWidth;
    lbImgHeight.Visible := pnlImage.Width >= previewMinWidth;
    lbImgHeightVal.Visible := pnlImage.Width >= previewMinWidth;
    lbImgOrigSize.Visible := pnlOriginal.Width >= origMinWidth;
    lbImgOrigSizeKBVal.Visible := pnlOriginal.Width > origMinWidth;
    lbImgOrigWidth.Visible := pnlOriginal.Width > origMinWidth;
    lbImgOrigWidthVal.Visible := pnlOriginal.Width > origMinWidth;
    lbImgOrigHeight.Visible := pnlOriginal.Width > origMinWidth;
    lbImgOrigHeightVal.Visible := pnlOriginal.Width > origMinWidth;
  finally
    if not cbStretchOriginal.Visible then
      cbStretchOriginal.Visible := true; //force update
  end;
end;

procedure TFrmMain.CheckStartOk(Sender: TObject);
begin
  btnStart.Enabled := (fMainController.FileIsSelected or fImageChanged) and
                      (cbIncludeInJSONFile.Checked or cbCompress.Checked or cbApplyGraphics.Checked) and
                      ((ExtractFilePath(ebStartPath.Text) <> '') and (ExtractFilePath(ebOutputDir.Text) <> ''));
end;

procedure TFrmMain.miClearFilesClick(Sender: TObject);
begin
  ebStartPath.Text := '';
  fFilenameList.Clear;
  Scan(Sender);
end;

procedure TFrmMain.CloseApplication1Click(Sender: TObject);
begin
  if MessageDlg(cMsgClosingApp, TMsgDlgType.mtConfirmation, mbOKCancel, 0) = mrOK then
    Close;
end;

procedure TFrmMain.DeploymentScript1Click(Sender: TObject);
begin
  with TFrmShellScript.Create(Self) do begin
    try
      OutputPath := ebOutputDir.Text;
      SourcePrefix := ebPrefix.Text;
      AllowSave := not fEvaluationMode;
      RunOnCompletion := fRunScript;
      ShowModal;
      if RecordModified then begin
        fRunScript := RunOnCompletion;
        fMainController.ToggleScriptLog;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFrmMain.miPurchaseLicenseClick(Sender: TObject);
begin
  fMainController.OpenURL(cGumRoadLink);
end;

procedure TFrmMain.miRefreshClick(Sender: TObject);
begin
  Scan(Sender);
end;

procedure TFrmMain.miReplaceOriginalsClick(Sender: TObject);
begin
  miReplaceOriginals.Checked := not miReplaceOriginals.Checked;
  fMainController.FormData.ReplaceOriginals := miReplaceOriginals.Checked;
  if fMainController.ValidSelection(Sender) then begin
    ebOutputDir.Enabled := not fMainController.FormData.ReplaceOriginals;
    ebFilename.Enabled := not fMainController.FormData.ReplaceOriginals;
    cbIncludeInJSONFile.Enabled := not fMainController.FormData.ReplaceOriginals;
    if cbIncludeInJSONFile.Checked then
      cbIncludeInJSONFile.Checked := false;
  end else
    miReplaceOriginals.Checked := false;
end;

procedure TFrmMain.miRestoreDefaultsClick(Sender: TObject);
var
  oldDeepScan: boolean;
  oldStartPath: string;
  msg: string;
begin
  if FileExists(cSettingsFilename) then
    msg := cRestoreDefaultsMessage + cRestoreDefaultsMessage2
  else
    msg := cRestoreDefaultsMessage;
  if MessageDlg(msg, mtWarning, mbOKCancel, 0) = mrOk then begin
    oldStartPath := ebStartPath.Text;
    oldDeepScan := miDeepScan.Checked;
    try
      fMainController.LoadFormSettings(true);
    finally
      if (oldStartPath <> ebStartPath.Text) or
         (oldDeepScan <> miDeepScan.Checked) then
        Scan(Sender);
    end;
  end;
end;

procedure TFrmMain.pcMainChange(Sender: TObject);
begin
  fMainController.ToggleScriptLog;
end;

procedure TFrmMain.pmViewsPopup(Sender: TObject);
begin
  miHideOriginalPm.Checked := not pnlOriginal.Visible;
  miSplit.Enabled := pnlOriginal.Visible;
  miHideImageList.Checked := not pnlFiles.Visible;
  miImgFullscreen.Checked := miFullscreen.Checked;
end;

procedure TFrmMain.ebDescriptionChange(Sender: TObject);
begin
  btnApply.Enabled := true;
end;

procedure TFrmMain.ebOutputDirChange(Sender: TObject);
begin
  if Assigned(fMainController) then begin
    if fMainController.FormData.AutoPrefix then
      SetPrefixDir(ebOutputDir.Text);
  end;
end;

procedure TFrmMain.ebPrefixChange(Sender: TObject);
begin
  btnApply.Enabled := true;
end;

procedure TFrmMain.ebStartPathEnter(Sender: TObject);
begin
  if ebStartPath.Text = '' then
    ShowFolderSelect(Sender);
end;

procedure TFrmMain.ebStartPathKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Scan(Sender);
end;

procedure TFrmMain.Refresh1Click(Sender: TObject);
begin
  Scan(Sender);
end;

procedure TFrmMain.ResizeEvent(Sender: TObject);
begin
  if (not fFormOpenClose) and
     (fSelectedFilename <> '') then begin
    Screen.Cursor := crHourGlass;
    try
      CheckHideLabels;
      if not cbStretch.Checked then
        fMainController.LoadImage(fJPEGCompressor.JPEG, imgHome);
      if not cbStretchOriginal.Checked then
        fMainController.LoadImage(fJPEGCompressor.JPEGOriginal, imgOriginal);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

function TFrmMain.SelectedFileCount: integer;
var
  a: integer;
begin
  result := 0;
  for a:=0 to cblFiles.Count-1 do begin
    if cblFiles.Checked[a] then
      Inc(result);
  end;
end;

procedure TFrmMain.miSelectOutputDirClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do begin
    try
      DefaultFolder := ebOutputDir.Text;
      Options := [fdoPickFolders];
      if Execute then begin
        imgHome.Align := alNone;
        fSelectedFilename := Filename;
        ebOutputDir.Text := FileName;
      end;
    finally
      Free;
      imgHome.Align := alClient;
    end;
  end;
end;

function TFrmMain.GetSelectedFileName: string;
var
  a: integer;
begin
  result := '';
  for a := 0 to cblFiles.Count-1 do begin
    if cblFiles.Selected[a] then begin
      result := cblFiles.Items[a];
      if ExtractFilePath(result) = '' then
        result := IncludeTrailingPathDelimiter(ebStartPath.Text)+cblFiles.Items[a];
      Break;
    end;
  end;
  if (result = '') and
     (cblFiles.Count > 0) then begin
    if ExtractFilePath(cblFiles.Items[0]) = '' then
      result := IncludeTrailingPathDelimiter(ebStartPath.Text)+cblFiles.Items[0]
    else
      result := cblFiles.Items[0];
  end;
  fImageChanged := result <> fSelectedFilename;
end;

procedure TFrmMain.SetChildControlES(const AParentControl: TControl; const AEnabled: Boolean);
var
  i: Integer;
begin
  if Assigned(AParentControl) then begin
    if AParentControl is TWinControl then begin
      for i := 0 to TWinControl(AParentControl).ControlCount-1 do
        SetChildControlES(TWinControl(AParentControl).Controls[i], AEnabled);
    end;
  end;
  if (AParentControl is TLabel) then
    TLabel(AParentControl).Enabled := AEnabled
  else if (AParentControl is TListView) then
    TListView(AParentControl).RowSelect := AEnabled
  else if not TListView(AParentControl).ReadOnly then
      TListView(AParentControl).ReadOnly := true
  else if (AParentControl is TWinControl) then
    AParentControl.Enabled := AEnabled;
end;

procedure TFrmMain.SetControlState(const AEnabled: boolean);
begin
  SetChildControlES(pnlImage, AEnabled);
  cbCompressPreview.Enabled := AEnabled;
  cbStretch.Enabled := AEnabled;
  imgHome.Enabled := AEnabled;
end;

procedure TFrmMain.SetEvaluationMode(const Value: boolean);
begin
  fEvaluationMode := Value;
  if fEvaluationMode then
    Caption := cEvaluationCaption
  else
    Caption := cActivatedCaption;
end;

procedure TFrmMain.SetPrefixDir(const AOutputPath: string);
var
  prefix,
  topDir: string;
begin
  topDir := ExtractFilename(AOutputPath);
  prefix := ebPrefix.Text;
  ebPrefix.Text := Copy(prefix, 0, prefix.LastIndexOf('/')+1) + topDir;
end;

procedure TFrmMain.SetShrinkState(Sender: TObject);
begin
  if not fLoading then begin
    rbByWidth.Enabled := cbApplyGraphics.Checked;
    rbByHeight.Enabled := cbApplyGraphics.Checked;
    seMaxWidthPx.Enabled := rbByWidth.Enabled and rbByWidth.Checked;
    lbMaxWidthPx.Enabled := rbByWidth.Enabled and rbByWidth.Checked;
    seMaxHeightPx.Enabled := rbByHeight.Enabled and rbByHeight.Checked;
    lbMaxHeightPx.Enabled := rbByHeight.Enabled and rbByHeight.Checked;
    cbResampleMode.Enabled := cbApplyGraphics.Checked;
    cbRotateAmount.Enabled := cbApplyGraphics.Checked;
    lbResampling.Enabled := cbApplyGraphics.Checked;
    lbRotation.Enabled := cbApplyGraphics.Checked;
    CheckCompressPreviewLoad(Sender);
    CheckStartOk(Sender);
  end;
end;
procedure TFrmMain.Settings1Click(Sender: TObject);
begin

end;

{$WARNINGS OFF} //Specific for Windows
procedure TFrmMain.ShowFolderSelect(Sender: TObject);
begin
  inherited;
  with TFileOpenDialog.Create(nil) do begin
    try
      if Sender = ebStartPath then
        DefaultFolder := fWorkingDir
      else
        DefaultFolder := ebStartPath.Text;
      Options := [fdoPickFolders];
      if Execute then begin
        if (Sender = ebStartPath) or
           (Sender = mmiOpenFolder) then begin
          ebStartPath.Text := FileName;
          Scan(Sender);
        end else
          ebOutputDir.Text := FileName;
      end;
    finally
      Free;
      Application.ProcessMessages;
    end;
  end;
end;

procedure TFrmMain.miHideFilesClick(Sender: TObject);
begin
  miHideFiles.Checked := not pnlFiles.Visible;
  pnlFiles.Visible := not pnlFiles.Visible;
  miHideFiles.Checked := not pnlFiles.Visible;
  ResizeEvent(Sender);
end;

procedure TFrmMain.miHideImageListClick(Sender: TObject);
begin
  miHideFilesClick(Sender);
  ResizeEvent(Sender);
end;

procedure TFrmMain.miHideOriginalClick(Sender: TObject);
begin
  miHideOriginal.Checked := not miHideOriginal.Checked;
  pnlOriginal.Visible := not miHideOriginal.Checked;
  spOriginal.Visible := not miHideOriginal.Checked;
  ResizeEvent(Sender);
end;

procedure TFrmMain.miHideOriginalPmClick(Sender: TObject);
begin
  miHideOriginalClick(Sender);
  ResizeEvent(Sender);
end;

procedure TFrmMain.ShowFileSelect(Sender: TObject);
begin                                     
  fMainController.ShowFileSelect(Sender);
end;
{$WARNINGS ON}
procedure TFrmMain.cbCompressClick(Sender: TObject);
begin
  if not fLoading then begin
    seQuality.Enabled := cbCompress.Checked and (seTargetKBs.Value = 0);
    tbQuality.Enabled := seQuality.Enabled;
    seTargetKBs.Enabled := cbCompress.Checked;
    lbQuality.Enabled := cbCompress.Checked;
    lbTargetKB.Enabled := cbCompress.Checked;
    CheckCompressPreviewLoad(Sender);
    CheckStartOk(Sender);
  end;
end;

procedure TFrmMain.cbIncludeInJSONFileClick(Sender: TObject);
begin
  ebPrefix.Enabled := cbIncludeInJSONFile.Checked;
  lbPrefix.Enabled := cbIncludeInJSONFile.Checked;
  lbDescription.Enabled := cbIncludeInJSONFile.Checked;
  ebDescription.Enabled := cbIncludeInJSONFile.Checked;
  btnApply.Enabled := true;
  CheckStartOk(Sender);
end;

procedure TFrmMain.spOriginalMoved(Sender: TObject);
begin
  ResizeEvent(Sender);
end;

procedure TFrmMain.FormResize(Sender: TObject);
begin
  ResizeEvent(Sender);
end;

procedure TFrmMain.tbQualityChange(Sender: TObject);
begin
  if not fLoadingPreview then begin
    CheckCompressPreviewLoad(Sender);
    seQuality.Value := tbQuality.Position;
  end;
end;

procedure TFrmMain.tbQualityKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    CheckCompressPreviewLoad(Sender);
end;

procedure TFrmMain.tmrOnShowTimer(Sender: TObject);
begin
  tmrOnShow.Enabled := false;
  MessageDlg('No images found in the default source directory. '+sLineBreak+sLineBreak+
             'Please drag and drop images or folders to build a compression queue.'+sLineBreak+sLineBreak+
             'Alternatively, use the File -> Open menu option.', TMsgDlgType.mtInformation, mbOKCancel, 0);
end;

procedure TFrmMain.tmrResizeTimer(Sender: TObject);
begin
  ResizeEvent(Sender)
end;

procedure TFrmMain.cblFilesClick(Sender: TObject);
begin
  inherited;
  if (GetSelectedFileName <> '') and
     (fImageChanged) then begin
    cbCompressPreview.Checked := false;
    fMainController.LoadSelectedFromFile;
    cbCompressClick(Sender);
    cbApplyGraphicsClick(Sender);
    if fImageChanged then
      btnApply.Enabled := true;
    cblFilesClickCheck(Sender);
  end;
end;

procedure TFrmMain.cblFilesClickCheck(Sender: TObject);
begin
  btnStart.Enabled := fMainController.FileIsSelected;
end;

procedure TFrmMain.cbResampleModeChange(Sender: TObject);
begin
  CheckCompressPreviewLoad(Sender);
  SetShrinkState(Sender);
end;

procedure TFrmMain.cbResampleModeExit(Sender: TObject);
begin
  if cbResampleMode.ItemIndex = -1 then
    cbResampleMode.ItemIndex := 0;
end;

procedure TFrmMain.cbResampleModeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then begin
    if cbResampleMode.ItemIndex = -1 then
      cbResampleMode.ItemIndex := 0;
      CheckCompressPreviewLoad(Sender);
  end;
end;

procedure TFrmMain.cbRotateAmountExit(Sender: TObject);
begin
  if cbRotateAmount.ItemIndex = -1 then
    cbRotateAmount.ItemIndex := 0;
end;

procedure TFrmMain.cbRotateAmountKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then begin
    if cbRotateAmount.ItemIndex = -1 then
      cbRotateAmount.ItemIndex := 0;
      CheckCompressPreviewLoad(Sender);
  end;
end;

procedure TFrmMain.miSaveSettingsClick(Sender: TObject);
begin
  fMainController.SaveFormSettings;
  MessageDlg(cMsgSaveSettings, mtInformation, [mbOK], 0);
end;

procedure TFrmMain.miShowOriginalClick(Sender: TObject);
begin
  pnlOriginal.Visible := not pnlOriginal.Visible;
  spOriginal.Visible := pnlOriginal.Visible;
end;

procedure TFrmMain.miSplitClick(Sender: TObject);
begin
  pnlOriginal.Width := Round((pnlImage.Width + pnlOriginal.Width) / 2);
  ResizeEvent(Sender);
end;

procedure TFrmMain.cbApplyGraphicsClick(Sender: TObject);
begin
  CheckCompressPreviewLoad(Sender);
  rbByWidth.Enabled := cbApplyGraphics.Checked;
  rbByHeight.Enabled := cbApplyGraphics.Checked;
  seMaxWidthPx.Enabled := rbByWidth.Enabled and rbByWidth.Checked;
  lbMaxWidthPx.Enabled := rbByWidth.Enabled and rbByWidth.Checked;
  seMaxHeightPx.Enabled := rbByHeight.Enabled and rbByHeight.Checked;
  lbMaxHeightPx.Enabled := rbByHeight.Enabled and rbByHeight.Checked;
  cbResampleMode.Enabled := cbApplyGraphics.Checked;
  cbRotateAmount.Enabled := cbApplyGraphics.Checked;
  lbResampling.Enabled := cbApplyGraphics.Checked;
  lbRotation.Enabled := cbApplyGraphics.Checked;
end;

procedure TFrmMain.cbStretchClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    imgHome.Stretch := cbStretch.Checked;
    fMainController.LoadImage(fJPEGCompressor.JPEG, imgHome);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.cbStretchOriginalClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    imgOriginal.Stretch := cbStretchOriginal.Checked;
    fMainController.LoadImage(fJPEGCompressor.JPEGOriginal, imgHome);
  finally
    Screen.Cursor := crDefault;
  end
end;

procedure TFrmMain.seMaxHeightPxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = vkReturn then
    CheckCompressPreviewLoad(Sender);
end;

procedure TFrmMain.seMaxWidthPxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = vkReturn then
    CheckCompressPreviewLoad(Sender);
end;

procedure TFrmMain.seQualityExit(Sender: TObject);
begin
  if tbQuality.Position = seQuality.Value then
    CheckCompressPreviewLoad(Sender)
  else
    tbQuality.Position := seQuality.Value;
end;

procedure TFrmMain.seQualityKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = vkReturn then begin
    tbQuality.Position := seQuality.Value;
    CheckCompressPreviewLoad(Sender);
  end;
end;

procedure TFrmMain.seTargetKBsChange(Sender: TObject);
begin
  seQuality.Enabled := seTargetKBs.Value <= 0;
  tbQuality.Enabled := seQuality.Enabled;
  btnApply.Enabled := true;
end;

procedure TFrmMain.seTargetKBsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = vkReturn then
    CheckCompressPreviewLoad(Sender);
end;

end.


