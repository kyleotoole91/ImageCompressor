unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics, Vcl.Samples.Spin,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus,
  Vcl.CheckLst, System.IOUtils, System.Types, System.UITypes, ShellApi, Vcl.Buttons, System.Classes, uConstants, uMainController;

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
    pnlFiles: TPanel;
    lbFiles: TLabel;
    cblFiles: TCheckListBox;
    pnlImage: TPanel;
    imgHome: TImage;
    spFiles: TSplitter;
    miClear: TMenuItem;
    pmLogs: TPopupMenu;
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
    miHideFiles: TMenuItem;
    btnApply: TButton;
    N1: TMenuItem;
    Refresh1: TMenuItem;
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
    miDeepScan: TMenuItem;
    miReplaceOriginals: TMenuItem;
    miClearFiles: TMenuItem;
    miSaveSettings: TMenuItem;
    miAdvanced: TMenuItem;
    miDeploymentScript: TMenuItem;
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
    pmScriptLogs: TPopupMenu;
    miClearSciptLogs: TMenuItem;
    N8: TMenuItem;
    miShowInGallery: TMenuItem;
    miShowInExplorer: TMenuItem;
    pnlConfig: TPanel;
    Panel5: TPanel;
    ebStartPath: TEdit;
    ebOutputDir: TEdit;
    lbOutputDir: TLabel;
    Label2: TLabel;
    pnlConfigFlow: TFlowPanel;
    pnlCompression: TPanel;
    GroupBox1: TGroupBox;
    lbQuality: TLabel;
    lbTargetKB: TLabel;
    seQuality: TSpinEdit;
    seTargetKBs: TSpinEdit;
    cbCompress: TCheckBox;
    pnlGraphics: TPanel;
    GroupBox3: TGroupBox;
    lbMaxHeightPx: TLabel;
    lbMaxWidthPx: TLabel;
    lbResampling: TLabel;
    lbRotation: TLabel;
    seMaxWidthPx: TSpinEdit;
    seMaxHeightPx: TSpinEdit;
    cbResampleMode: TComboBox;
    cbRotateAmount: TComboBox;
    cbApplyGraphics: TCheckBox;
    pnlIncludeInFile: TPanel;
    GroupBox2: TGroupBox;
    lbDescription: TLabel;
    lbTitle: TLabel;
    ebDescription: TEdit;
    ebTitle: TEdit;
    cbIncludeInJSONFile: TCheckBox;
    pnlGlobals: TPanel;
    GroupBox4: TGroupBox;
    lbFilename: TLabel;
    lbPrefix: TLabel;
    cbApplyToAll: TCheckBox;
    ebFilename: TEdit;
    ebPrefix: TEdit;
    lbClientWidth: TLabel;
    lbClientHeight: TLabel;
    miOpenWith: TMenuItem;
    N9: TMenuItem;
    ClearImageList1: TMenuItem;
    N10: TMenuItem;
    StretchandSplit1: TMenuItem;
    rbQuality: TRadioButton;
    rbTarget: TRadioButton;
    tbQuality: TTrackBar;
    cbCreateThumbnails: TCheckBox;
    rbByWidth: TRadioButton;
    rbByHeight: TRadioButton;
    cbSetThumbnailSize: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    miFileSaveSettings: TMenuItem;
    procedure btnStartClick(Sender: TObject);
    procedure seTargetKBsChange(Sender: TObject);
    procedure cbCompressClick(Sender: TObject);
    procedure cbIncludeInJSONFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SetShrinkState(Sender: TObject);
    procedure miClearClick(Sender: TObject);
    procedure btnScanClick(Sender: TObject);
    procedure mniUnSelectAllClick(Sender: TObject);
    procedure mniSelectAllClick(Sender: TObject);
    procedure cblFilesClick(Sender: TObject);
    procedure CheckCompressPreviewLoad(Sender: TObject);
    procedure seMaxWidthPxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seMaxHeightPxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seTargetKBsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seQualityKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    procedure ebStartPathKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure miClearFilesClick(Sender: TObject);
    procedure miSaveSettingsClick(Sender: TObject);
    procedure miDeploymentScriptClick(Sender: TObject);
    procedure miSelectOutputDirClick(Sender: TObject);
    procedure tmrOnShowTimer(Sender: TObject);
    procedure ebOutputDirChange(Sender: TObject);
    procedure miAutoPrefixClick(Sender: TObject);
    procedure miRestoreDefaultsClick(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure miClearSciptLogsClick(Sender: TObject);
    procedure ebStartPathDblClick(Sender: TObject);
    procedure cblFilesClickCheck(Sender: TObject);
    procedure ebOutputDirDblClick(Sender: TObject);
    procedure mmiOpenFolderClick(Sender: TObject);
    procedure mmiOpenClick(Sender: TObject);
    procedure miShowInGalleryClick(Sender: TObject);
    procedure miShowInExplorerClick(Sender: TObject);
    procedure pmCheckBoxListPopup(Sender: TObject);
    procedure spFilesMoved(Sender: TObject);
    procedure miOpenWithClick(Sender: TObject);
    procedure ClearImageList1Click(Sender: TObject);
    procedure StretchandSplit1Click(Sender: TObject);
    procedure rbTargetClick(Sender: TObject);
    procedure rbQualityClick(Sender: TObject);
    procedure cbSetThumbnailSizeClick(Sender: TObject);
    procedure miFileSaveSettingsClick(Sender: TObject);
    procedure cbApplyToAllClick(Sender: TObject);
  strict private
    fMainController: TMainController;
    fDirectoryScanned,
    fEvaluationMode,
    fFormOpenClose,
    fLoading: boolean;
    fFormCreating: boolean;
    fFilenameList: TStringList;
  public
    { Private declarations }
    procedure SetPrefixDir(const AOutputPath: string);
    function SelectedFileCount: integer;
    procedure SetControlState(const AEnabled: boolean);
    procedure SetEvaluationMode(const Value: boolean);
    procedure AcceptFiles(var AMsg: TMessage); message WM_DROPFILES;
    { Public declarations }
    property EvaluationMode: boolean read fEvaluationMode write SetEvaluationMode;
    property FormOpenClose: boolean read fFormOpenClose;
    property Loading: boolean read fLoading write fLoading;
    property FilenameList: TStringList read fFilenameList;
    property FormCreating: boolean read fFormCreating;
    property DirectoryScanned: boolean read fDirectoryScanned write fDirectoryScanned;
  end; 
  
var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  inherited;
  DragAcceptFiles(Self.Handle, true);
  fFormOpenClose := true;
  fFilenameList := TStringList.Create;
  fDirectoryScanned := true;
  fFormCreating := true;
  fEvaluationMode := true;
  fLoading := false;
  seTargetKBs.Value := cDefaultTargetKB;
  tbQuality.Min := cMinQuality;
  tbQuality.Max := cMaxQuality;
  seQuality.MaxValue := cMaxQuality;
  seQuality.MinValue := cMinQuality;
  seQuality.Value := cMaxQuality;
  seMaxWidthPx.Value := cDefaultMaxWidth;
  seMaxHeightPx.Value := cDefaultMaxHeight;
  pcMain.ActivePage := tsHome;
  pnlFiles.Width := cDefaultFilesWidth;
  ClientWidth := cDefaultClientWidth;
  ClientHeight := cDefaultClientHeight;
  spOriginal.Left := cDefaultImageSplitPause;
  tmrOnShow.Enabled := false;
  fMainController := TMainController.Create(Self);
  ebOutputDir.Text := fMainController.OutputDir;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  try
    try
      fFilenameList.Free;
      fMainController.ClearConfigList;
      fMainController.Free;
    except
    end;
  finally
    inherited;
  end;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fFormOpenClose := true;
  DragAcceptFiles(Self.Handle, false);
  inherited;
end;

procedure TFrmMain.miFilesSizeFilterClick(Sender: TObject);
begin
  fMainController.ShowFileSizeFilter(Sender);
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;
  try
    fFormOpenClose := true;
    mmMessages.Clear;
    pcMain.ActivePage := tsHome;
    ebStartPath.Text := fMainController.WorkingDir;
    fFormCreating := false;
  finally
    Screen.Cursor := crDefault;
    fMainController.LoadFormSettings;
    fMainController.Scan(Sender);
    fFormOpenClose := false;
    mmMessages.Lines.Clear;
    mmScript.Lines.Clear;
    if fMainController.SelectedFilename = '' then
      tmrOnShow.Enabled := true;
  end;
end;

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
  pnlConfigFlow.Visible := pnlConfig.Visible;
  miHideConfig.Checked := pnlConfig.Visible;
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
  fMainController.DeepScanClick(Sender);
end;

procedure TFrmMain.miDownloadClick(Sender: TObject);
begin
  fMainController.OpenURL(cLatestVersionURL);
end;

procedure TFrmMain.miEnterLicenseClick(Sender: TObject);
begin
  fMainController.ShowEnterLicenseKey(Sender);
end;

procedure TFrmMain.miFullscreenClick(Sender: TObject);
begin
  fMainController.FullScreenClick(Sender);
end;

procedure TFrmMain.AcceptFiles(var AMsg: TMessage);
const
  cnMaxCharArrayLen = 255;
var
  a,
  errCount: integer;
  fileCount: integer;
  filename: string;
  //selectedIndex: integer;
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
    if (AFilename <> '') and
       (fFilenameList.IndexOf(AFilename) = -1) then
      fFilenameList.Insert(0, AFilename)
  end;
begin
  errCount := 0;
  fMainController.DragAndDropping := true;
  try
    try
      fileCount := DragQueryFile(AMsg.WParam, $FFFFFFFF, caFilename, cnMaxCharArrayLen);
      if fDirectoryScanned then begin
        fMainController.CheckAddPath;
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
      fMainController.AddMissingPaths;
      fMainController.Scan(nil, false);
      for a := 0 to cblFiles.Count-1 do begin
        if cblFiles.Items[a] = filename then begin
          cblFiles.Selected[a] := true;
          break;
        end;
      end;
      fMainController.LoadSelectedFromFile;
      cblFiles.SetFocus;
    except
      on e: exception do
        MessageDlg(e.ClassName+' '+e.Message, TMsgDlgType.mtError, [mbOk], 0);
    end;
  finally
    fMainController.DragAndDropping := false;
    DragFinish(AMsg.WParam);
  end;
end;

procedure TFrmMain.miApplyBestFitClick(Sender: TObject);
begin
  miApplyBestFit.Checked := not miApplyBestFit.Checked;
  Screen.Cursor := crHourGlass;
  try
    fMainController.LoadImage(true, imgHome, miApplyBestFit.Checked);
    fMainController.LoadImage(false, imgOriginal, miApplyBestFit.Checked);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.miAutoPrefixClick(Sender: TObject);
begin
  miAutoPrefix.Checked := not miAutoPrefix.Checked;
  fMainController.FormData.AutoPrefix := miAutoPrefix.Checked;
  if fMainController.FormData.AutoPrefix then
    SetPrefixDir(ebOutputDir.Text);
end;

procedure TFrmMain.btnApplyClick(Sender: TObject);
begin
  fMainController.ApplyClick(Sender)
end;

procedure TFrmMain.btnScanClick(Sender: TObject);
begin
  fMainController.Scan(Sender);
end;

procedure TFrmMain.btnStartClick(Sender: TObject);
begin
  fMainController.StartClick(Sender);
end;

procedure TFrmMain.CheckCompressPreviewLoad(Sender: TObject);
begin
  fMainController.CheckCompressPreviewLoad(Sender);
end;

procedure TFrmMain.miClearFilesClick(Sender: TObject);
begin
  fMainController.ClearFilesClick(Sender);
end;

procedure TFrmMain.miClearSciptLogsClick(Sender: TObject);
begin
  mmScript.Lines.BeginUpdate;
  try
    mmScript.Lines.Clear;
  finally
    mmScript.Lines.EndUpdate;
  end;
end;

procedure TFrmMain.ClearImageList1Click(Sender: TObject);
begin
  fMainController.ClearFilesClick(Sender);
end;

procedure TFrmMain.CloseApplication1Click(Sender: TObject);
begin
  if MessageDlg(cMsgClosingApp, TMsgDlgType.mtConfirmation, mbOKCancel, 0) = mrOK then
    Close;
end;

procedure TFrmMain.miDeploymentScriptClick(Sender: TObject);
begin
  fMainController.ShowDeploymentScript(Sender);
end;

procedure TFrmMain.miPurchaseLicenseClick(Sender: TObject);
begin
  fMainController.OpenURL(cGumRoadLink);
end;

procedure TFrmMain.miRefreshClick(Sender: TObject);
begin
  fMainController.Refresh(Sender);
end;

procedure TFrmMain.miReplaceOriginalsClick(Sender: TObject);
begin
  fMainController.ReplaceOriginals(Sender);
end;

procedure TFrmMain.miRestoreDefaultsClick(Sender: TObject);
begin
  fMainController.RestoreDefaults(Sender);
end;

procedure TFrmMain.pcMainChange(Sender: TObject);
begin
  fMainController.ToggleScriptLog;
end;

procedure TFrmMain.pmCheckBoxListPopup(Sender: TObject);
begin
  fMainController.CheckListPopup(Sender);
end;

procedure TFrmMain.pmViewsPopup(Sender: TObject);
begin
  fMainController.ViewsPopup(Sender);
end;

procedure TFrmMain.rbQualityClick(Sender: TObject);
begin
  fMainController.QualityRadioClick(Sender);
end;

procedure TFrmMain.rbTargetClick(Sender: TObject);
begin
 fMainController.QualityRadioClick(Sender);
end;

procedure TFrmMain.ebDescriptionChange(Sender: TObject);
begin
  btnApply.Enabled := true;
end;

procedure TFrmMain.ebOutputDirChange(Sender: TObject);
begin
  if fMainController.FormData.AutoPrefix then
    SetPrefixDir(ebOutputDir.Text);
end;

procedure TFrmMain.ebOutputDirDblClick(Sender: TObject);
begin
  fMainController.ShowFolderSelect(Sender);
end;

procedure TFrmMain.ebPrefixChange(Sender: TObject);
begin
  btnApply.Enabled := true;
end;

procedure TFrmMain.ebStartPathDblClick(Sender: TObject);
begin
  fMainController.ShowFolderSelect(Sender);
end;

procedure TFrmMain.ebStartPathKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    fMainController.Scan(Sender);
end;

procedure TFrmMain.Refresh1Click(Sender: TObject);
begin
  fMainController.Scan(Sender);
end;

procedure TFrmMain.miFileSaveSettingsClick(Sender: TObject);
begin
  miSaveSettings.Click;
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
  fMainController.ShowFolderSelect(Sender);
end;

procedure TFrmMain.SetControlState(const AEnabled: boolean);
begin
  fMainController.SetControlState(AEnabled);
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
begin
  ebPrefix.Text := Copy(ebPrefix.Text, 0, String(ebPrefix.Text).LastIndexOf('/')+1) + ExtractFilename(AOutputPath);
end;

procedure TFrmMain.SetShrinkState(Sender: TObject);
begin
  fMainController.SetShrinkState(Sender);
end;

procedure TFrmMain.spFilesMoved(Sender: TObject);
begin
  fMainController.ResizeEvent(Sender);
end;

procedure TFrmMain.miHideFilesClick(Sender: TObject);
begin
  fMainController.HideFilesClick(Sender);
end;

procedure TFrmMain.miHideImageListClick(Sender: TObject);
begin
  miHideFilesClick(Sender);
  fMainController.ResizeEvent(Sender);
end;

procedure TFrmMain.miHideOriginalClick(Sender: TObject);
begin
  fMainController.HideOriginalClick(Sender);
end;

procedure TFrmMain.miHideOriginalPmClick(Sender: TObject);
begin
  miHideOriginalClick(Sender);
  fMainController.ResizeEvent(Sender);
end;

procedure TFrmMain.miOpenWithClick(Sender: TObject);
begin
  fMainController.OpenWith(Sender);
end;

procedure TFrmMain.cbCompressClick(Sender: TObject);
begin
  if not fLoading then
    fMainController.CompressClick(Sender);
end;

procedure TFrmMain.cbIncludeInJSONFileClick(Sender: TObject);
begin
  fMainController.IncludeInFileClick(Sender);
end;

procedure TFrmMain.spOriginalMoved(Sender: TObject);
begin
  fMainController.ResizeEvent(Sender);
end;

procedure TFrmMain.StretchandSplit1Click(Sender: TObject);
begin
  cbStretchOriginal.Checked := true;
  cbStretch.Checked := true;
  fMainController.StretchClick(cbStretch);
  fMainController.StretchClick(cbStretchOriginal);
  miSplitClick(miSplit);
  //TODO: Force the scale of the smaller scale previewed jpeg to that of the large one, this will improve image quality
end;

procedure TFrmMain.FormResize(Sender: TObject);
begin
  if not fFormOpenClose then
    fMainController.ResizeEvent(Sender);
end;

procedure TFrmMain.tbQualityChange(Sender: TObject);
begin
  fMainController.QualityChange(Sender);
end;

procedure TFrmMain.tbQualityKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    CheckCompressPreviewLoad(Sender);
end;

procedure TFrmMain.tmrOnShowTimer(Sender: TObject);
begin
  tmrOnShow.Enabled := false;
  MessageDlg(cMsgNoImagesFound, TMsgDlgType.mtInformation, mbOKCancel, 0);
end;

procedure TFrmMain.tmrResizeTimer(Sender: TObject);
begin
  fMainController.ResizeEvent(Sender)
end;

procedure TFrmMain.cblFilesClick(Sender: TObject);
begin
  inherited;
  fMainController.FilesClick(Sender);
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
  if (key = VK_RETURN) and
     (cbResampleMode.ItemIndex = -1) then begin
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

procedure TFrmMain.miShowInExplorerClick(Sender: TObject);
begin
  fMainController.OpenSelectedExplorer(Sender);
end;

procedure TFrmMain.miShowInGalleryClick(Sender: TObject);
begin
  fMainController.OpenSelectedImage(Sender);
end;

procedure TFrmMain.miShowOriginalClick(Sender: TObject);
begin
  pnlOriginal.Visible := not pnlOriginal.Visible;
  spOriginal.Visible := pnlOriginal.Visible;
end;

procedure TFrmMain.miSplitClick(Sender: TObject);
begin
  pnlOriginal.Width := Round((pnlImage.Width + pnlOriginal.Width) / 2);
  fMainController.ResizeEvent(Sender);
end;

procedure TFrmMain.mmiOpenClick(Sender: TObject);
begin
  fMainController.ShowFileSelect(Sender);
end;

procedure TFrmMain.mmiOpenFolderClick(Sender: TObject);
begin
  fMainController.ShowFolderSelect(Sender);
end;

procedure TFrmMain.cbApplyGraphicsClick(Sender: TObject);
begin
  fMainController.ApplyGraphicsClick(Sender);
end;

procedure TFrmMain.cbApplyToAllClick(Sender: TObject);
begin
  btnApply.Enabled := not cbApplyToAll.Checked;
end;

procedure TFrmMain.cbSetThumbnailSizeClick(Sender: TObject);
begin
  fMainController.ShowDlgThumbnailSize(Sender);
end;

procedure TFrmMain.cbStretchClick(Sender: TObject);
begin
  fMainController.StretchClick(Sender);
end;

procedure TFrmMain.cbStretchOriginalClick(Sender: TObject);
begin
  fMainController.StretchClick(Sender);
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
  fMainController.TargetFilesizeChange(Sender);
end;

procedure TFrmMain.seTargetKBsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = vkReturn then
    CheckCompressPreviewLoad(Sender);
end;

end.


