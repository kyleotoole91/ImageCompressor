unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, uJPEGCompressor,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Samples.Spin, SuperObject, Vcl.ComCtrls, Vcl.Menus,
  Vcl.CheckLst, System.IOUtils, System.Types, System.UITypes, DateUtils, ShellApi, DosCommand, uFormData,
  Vcl.Buttons, Generics.Collections, Img32.Panels, uImageConfig, uLicenseValidator, uConstants, uScriptVariables;

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
  private
    { Private declarations }
    fRunScript: boolean;
    fScriptVariables: TScriptVariables;
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
    fImageConfigList: TDictionary<string, TImageConfig>;
    fFilenameList: TStringList;
    fFormData: TFormData;
    procedure ToggleScriptLog(const AStartup: boolean=false);
    procedure SetPrefixDir(const AOutputPath: string);
    procedure RunDeploymentScript;
    function ValidSelection(Sender: TObject): boolean;
    function LoadSelectedFromFile(const ALoadForm: boolean=true): boolean;
    function GetSelectedFileName: string;
    function FileIsSelected: boolean;
    function SelectedFileCount: integer;
    function SizeOfFileKB(const AFilename: string): uInt64;
    function FormToObj(const AImageConfig: TImageConfig=nil): TImageConfig;
    procedure ObjToForm(AImageConfig: TImageConfig=nil; const AOnlyFormData: boolean=false);
    procedure HasPayWallConfig(out AHasTargetKB, AHasResampling, AHasMultipleImages, AHasReplaceOriginals: boolean);
    procedure OpenURL(const AURL: string);
    procedure CheckHideLabels;
    procedure LoadImage(const AJPEG: TJPEGImage; const AImage: TImage);
    procedure LoadImageConfig(const AFilename: string);
    procedure SetControlState(const AEnabled: boolean);
    procedure SetChildControlES(const AParentControl: TControl; const AEnabled: Boolean);
    procedure LoadImagePreview(const AFilename: string); overload;
    procedure AddToJSONFile(const AOriginalFileSize: Int64; const ACompressedFileSize: Int64);
    procedure ProcessFile(const AFilename: string);
    procedure CreateJSONFile(const AJSON: ISuperObject);
    procedure ClearConfigList;
    procedure SetEvaluationMode(const Value: boolean);
    procedure AcceptFiles(var AMsg: TMessage); message WM_DROPFILES;
    procedure SaveFormSettings;
    procedure LoadFormSettings(const ARestoreDefaults: boolean=false);
    procedure ScanDisk;
  public
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
  ToggleScriptLog(true);
  fRunScript := false;
  fFormData := TFormData.Create;
  fScriptVariables := TScriptVariables.Create(Self);
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
  fImageConfigList := TDictionary<string, TImageConfig>.Create;
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
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  try
    ClearConfigList;
    fFilenameList.Free;
    fImageConfigList.Free;
    fMessages.Free;
    fJPEGCompressor.Free;
    fLicenseValidator.Free;
    fScriptVariables.Free;
    fFormData.Free;
  finally
    inherited;
  end;
end;

function TFrmMain.FileIsSelected: boolean;
var
  a: integer;
begin
  result := false;
  for a:=0 to cblFiles.Count-1 do begin
    result := cblFiles.Checked[a];
    if result then
      Break;
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
    LoadFormSettings;
    Scan(Sender);
    fFormOpenClose := false;
    mmMessages.Lines.Clear;
    if fSelectedFilename = '' then
      tmrOnShow.Enabled := true;
  end;
end;

function TFrmMain.FormToObj(const AImageConfig: TImageConfig=nil): TImageConfig;
begin
  if (fSelectedFilename <> '') or Assigned(AImageConfig) then begin
    if Assigned(AImageConfig) then
      result := AImageConfig
    else
      result := fImageConfig;
    if Assigned(result) then begin
      with result do begin
        Compress := cbCompress.Checked;
        Quality := seQuality.Value;
        TargetKB := seTargetKBs.Value;
        AddToJSON := cbIncludeInJSONFile.Checked;
        Description := ebDescription.Text;
        SourcePrefix := ebPrefix.Text;
        ApplyGraphics := cbApplyGraphics.Checked;
        Filename := fSelectedFilename;
        ShrinkByWidth := rbByWidth.Checked;
        PreviewCompression := cbCompressPreview.Checked;
        Stretch := cbStretch.Checked;
        RotateAmount := TRotateAmount(cbRotateAmount.ItemIndex);
        ResampleMode := TResampleMode(cbResampleMode.ItemIndex);
        if ShrinkByWidth then
          ShrinkByValue := seMaxWidthPx.Value
        else
          ShrinkByValue := seMaxHeightPx.Value;
        Filename := fSelectedFilename;
        if AImageConfig is TFormData then begin
          with TFormData(AImageConfig) do begin
            DeepScan := miDeepScan.Checked;
            ReplaceOriginals := miReplaceOriginals.Checked;
            AutoPrefix := miAutoPrefix.Checked;
            SourceDir := ebStartPath.Text;
            OutputDir := ebOutputDir.Text;
            FilterSizeKB := fFilterSizeKB;
            PnlFilesWidth := pnlFiles.Width;
            PnlOriginalWidth := pnlOriginal.Width;
            ApplyToAll := cbApplyToAll.Checked;
            JsonFilename := ebFilename.Text;
            Prefix := ebPrefix.Text;
            RunScript := fRunScript;
          end;
        end;
      end;
    end;
  end else
    result := nil;
end;

procedure TFrmMain.HasPayWallConfig(out AHasTargetKB, AHasResampling, AHasMultipleImages, AHasReplaceOriginals: boolean);
var
  key: string;
  imgConfig: TImageConfig;
begin
  AHasMultipleImages := SelectedFileCount > 1;
  AHasReplaceOriginals := fFormData.ReplaceOriginals;
  if cbApplyToAll.Checked then begin
    AHasTargetKB := cbCompress.Checked and (seTargetKBs.Value > 0);
    AHasResampling := cbApplyGraphics.Checked and (cbResampleMode.ItemIndex > integer(rmRecommended)); //allow rmRecommended in demo
  end else begin
    AHasTargetKB := false;
    AHasResampling := false;
    for key in fImageConfigList.Keys do begin
      if fImageConfigList.TryGetValue(key, imgConfig) then begin
        //allow target file size in evaluation
        //AHasTargetKB := AHasTargetKB or (imgConfig.Compress and (imgConfig.TagetKB > 0));
        AHasResampling := AHasResampling or (imgConfig.ApplyGraphics and (imgConfig.ResampleMode <> rmNone));
        if AHasTargetKB and AHasResampling then
          Break;
      end;
    end;
  end;
end;

procedure TFrmMain.LoadImageConfig(const AFilename: string);
var
  key: string;
begin
  if fSelectedFilename <> '' then begin
    key := fSelectedFilename;
    fImageConfigList.TryGetValue(key, fImageConfig);
    if not Assigned(fImageConfig) then begin
      fImageConfig := TImageConfig.Create;
      fImageConfig.Filename := fSelectedFilename;
      fImageConfig.Quality := fFormData.Quality;
      fImageConfig.Compress := fFormData.Compress;
      fImageConfig.ApplyGraphics := fFormData.ApplyGraphics;
      fImageConfig.TargetKB := fFormData.TargetKB;
      fImageConfig.ShrinkByWidth := fFormData.ShrinkByWidth;
      fImageConfig.ShrinkByValue := fFormData.ShrinkByValue;
      fImageConfig.ResampleMode := fFormData.ResampleMode;
      fImageConfig.RotateAmount := fFormData.RotateAmount;
      fImageConfig.AddToJSON := fFormData.AddToJSON;
      fImageConfig.Description := fFormData.Description;
      fImageConfig.SourcePrefix := fFormData.SourcePrefix;
      fImageConfigList.Add(fSelectedFilename, fImageConfig);
    end;
  end;
  if Assigned(fImageConfig) and fEvaluationMode then
    fImageConfig.ResampleMode := rmRecommended;
end;

procedure TFrmMain.ObjToForm(AImageConfig: TImageConfig=nil; const AOnlyFormData: boolean=false);
var
  imageConfig: TImageConfig;
begin
  fLoading := true;
  try
    if Assigned(AImageConfig) then
      imageConfig := AImageConfig
    else
      imageConfig := fImageConfig;
    if Assigned(imageConfig) then begin
      with imageConfig do begin
        if not AOnlyFormData then begin
          cbCompress.Checked := Compress;
          seQuality.Value := Quality;
          tbQuality.Position := Quality;
          seTargetKBs.Value := TargetKB;
          cbIncludeInJSONFile.Checked := AddToJSON;
          ebDescription.Text := Description;
          ebPrefix.Text := SourcePrefix;
          cbApplyGraphics.Checked := ApplyGraphics;
          fSelectedFilename := Filename;
          rbByWidth.Checked := ShrinkByWidth;
          rbByHeight.Checked := not ShrinkByWidth;
          cbCompressPreview.Checked := false;
          cbStretch.Checked := Stretch;
          cbRotateAmount.ItemIndex := integer(RotateAmount);
          cbResampleMode.ItemIndex := integer(ResampleMode);
          if rbByWidth.Checked then
            seMaxWidthPx.Value := ShrinkByValue
          else
            seMaxHeightPx.Value := ShrinkByValue;
          if fSelectedFilename <> '' then
            Filename := fSelectedFilename;
        end;
        if AImageConfig is TFormData then begin
          with TFormData(AImageConfig) do begin
            miDeepScan.Checked := DeepScan;
            miReplaceOriginals.Checked := ReplaceOriginals;
            miAutoPrefix.Checked := AutoPrefix;
            ebStartPath.Text := SourceDir;
            ebOutputDir.Text := OutputDir;
            fFilterSizeKB := FilterSizeKB;
            pnlFiles.Width := PnlFilesWidth;
            pnlOriginal.Width := PnlOriginalWidth;
            cbApplyToAll.Checked := ApplyToAll;
            ebFilename.Text := JsonFilename;
            ebPrefix.Text := Prefix;
            fRunScript := RunScript;
          end;
        end;
      end;
    end;
  finally
    fLoading := false;
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
      FormToObj(imageConfig);
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
      LoadImage(fJPEGCompressor.JPEG, imgHome);
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

procedure TFrmMain.LoadImagePreview(const AFilename: string);
begin
  if (AFilename <> '') and Assigned(fJPEGCompressor) then begin
    Screen.Cursor := crHourGlass;
    try
      fSelectedFilename := AFilename;
      fJPEGCompressor.JPEG.Scale := jsFullsize;
      fJPEGCompressor.JPEG.LoadFromFile(AFilename);
      LoadImage(fJPEGCompressor.JPEG, imgHome);
      if imgOriginal.Visible then begin
        fJPEGCompressor.JPEGOriginal.Scale := jsFullsize;
        fJPEGCompressor.JPEGOriginal.LoadFromFile(AFilename);
        lbImgOrigWidthVal.Caption := fJPEGCompressor.JPEGOriginal.Width.ToString;
        lbImgOrigHeightVal.Caption := fJPEGCompressor.JPEGOriginal.Height.ToString;
        lbImgOrigSizeKBVal.Caption := SizeOfFileKB(AFilename).ToString;
        LoadImage(fJPEGCompressor.JPEGOriginal, imgOriginal);
      end;
    finally
      Screen.Cursor := crDefault;
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

function TFrmMain.LoadSelectedFromFile(const ALoadForm: boolean=true): boolean;
begin
  try
    Screen.Cursor := crHourGlass;
    try
      fImageChanged := true;
      fSelectedFilename := GetSelectedFileName;
      result := (fSelectedFilename <> '') and FileExists(fSelectedFilename);
      if (fImageChanged) or
         (not result) then //to the image
        LoadImagePreview(fSelectedFilename);
      if ALoadForm and
         fImageChanged then begin
        LoadImageConfig(fSelectedFilename);
        ObjToForm;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  except
    on e: exception do begin
      MessageDlg(e.Classname+' '+e.message, mtError, [mbOK], 0);
      btnApply.Enabled := false;
      result := false;
    end;
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
  OpenURL(cContactVersionURL);
end;

procedure TFrmMain.miDeepScanClick(Sender: TObject);
begin
  if fEvaluationMode then begin
    if MessageDlg(cDeepScanEval+sLineBreak+sLineBreak+cLinkToBuyMessage, mtWarning, mbOKCancel, 0) = mrOk then
      OpenURL(cGumRoadLink);
  end else begin
    miDeepScan.Checked := not miDeepScan.Checked;
    fFormData.DeepScan := miDeepScan.Checked;
    Scan(Sender);
  end;
end;

procedure TFrmMain.miDownloadClick(Sender: TObject);
begin
  OpenURL(cLatestVersionURL);
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
    LoadSelectedFromFile;
  finally
    fDrapAndDropping := false;
    DragFinish(AMsg.WParam);
  end;
end;

procedure TFrmMain.AddToJSONFile(const AOriginalFileSize: Int64; const ACompressedFileSize: Int64);
var
  sourcePrefix: string;
begin
  with fJSON.AsArray do begin
    Add(NewJSONObject);
    sourcePrefix := fImageConfig.SourcePrefix;
    if sourcePrefix <> '' then begin
      if (sourcePrefix.Contains('/')) and
         (not sourcePrefix.EndsWith('/')) then
        sourcePrefix := sourcePrefix +'/'
      else if (sourcePrefix.Contains('\')) and
              (not sourcePrefix.EndsWith('\')) then
        sourcePrefix := sourcePrefix + '\';
      sourcePrefix := sourcePrefix + ExtractFileName(fImageConfig.Filename);
    end;
    O[Count-1].S['original'] := sourcePrefix;
    O[Count-1].S['description'] := fImageConfig.Description;
    O[Count-1].I['fileSize'] := ACompressedFileSize;
    O[Count-1].I['originalFilesize'] := AOriginalFileSize;
  end;
  fMessages.Add('Added '+fImageConfig.Filename+' to JSON file')
end;

procedure TFrmMain.SaveFormSettings;
var
  jsonStr: string;
  json: ISuperObject;
begin
  try
    FormToObj(fFormData);
    jsonStr := TJson.ObjectToJsonString(fFormData);
    json := SO(jsonStr);
    json.S['sourceDir'] := ebStartPath.Text;
    json.S[cOutputDir] := ebOutputDir.Text;
    json.I['filterSizeKB'] := fFilterSizeKB;
    json.B['replaceOriginals'] := fFormData.ReplaceOriginals;
    json.B['deepScan'] := fFormData.DeepScan;
    json.I['pnlFilesWidth'] := pnlFiles.Width;
    json.I['pnlScriptHeight'] := pnlScript.Height;
    json.I['pnlOriginalWidth'] := pnlOriginal.Width;
    json.B['applyToAll'] := cbApplyToAll.Checked;
    json.S['jsonFilename'] := ebFilename.Text;
    json.S['prefix'] := ebPrefix.Text;
    json.B['runScript'] := fRunScript;
    json.B['autoPrefix'] := fFormData.AutoPrefix;
    json.SaveTo(cSettingsFilename);
  finally
    json := nil;
  end;
end;

procedure TFrmMain.LoadFormSettings(const ARestoreDefaults: boolean=false);
var
  sl: TStringList;
  json: ISuperObject;
begin
  sl := TStringList.Create;
  try
    if Assigned(fFormData) then begin
      fFormData.Free;
      fFormData := nil;
    end;
    if (not ARestoreDefaults) and
       (FileExists(cSettingsFilename)) then begin
      sl.LoadFromFile(cSettingsFilename);
      fFormData := TJson.JsonToObject<TFormData>(sl.Text);
      try
        if Assigned(fFormData) then begin
          ObjToForm(fFormData);
          json := SO(sl.Text);
          if json.S['sourceDir'] <> '' then
            ebStartPath.Text := json.S['sourceDir'];
          if ebOutputDir.Text <> '' then
            ebOutputDir.Text := json.S[cOutputDir];
          fFilterSizeKB := json.I['filterSizeKB'];
          fFormData.ReplaceOriginals := json.B['replaceOriginals'];
          fFormData.DeepScan := json.B['deepScan'];
          cbApplyToAll.Checked := json.B['applyToAll'];
          ebFilename.Text := json.S['jsonFilename'];
          pnlOriginal.Width := json.I['pnlOriginalWidth'];
          pnlScript.Height := json.I['pnlScriptHeight'];
          fFormData.RunScript := json.B['runScript'];
          ebPrefix.Text := json.S['prefix'];
          fFormData.AutoPrefix := json.B['autoPrefix'];
          if pnlFiles.Width <> 0 then
            pnlFiles.Width := json.I['pnlFilesWidth'];
        end;
      finally
        fSelectedFilename := '';
      end;
    end;
    if not Assigned(fFormData) then begin
      fFormData := TFormData.Create;
      if ARestoreDefaults then begin
        with TImageConfig.Create do begin
          try
            fFormData.Quality := Quality;
            fFormData.FilterSizeKB := 0;
            fFormData.Compress := Compress;
            fFormData.TargetKB := TargetKB;
            fFormData.ResampleMode := ResampleMode;
            fFormData.RotateAmount := RotateAmount;
            fFormData.ApplyGraphics := ApplyGraphics;
            fFormData.Description := Description;
            fFormData.Description := Description;
            fFormData.ShrinkByWidth := ShrinkByWidth;
            fFormData.ShrinkByValue := ShrinkByValue;
            pnlFiles.Width := 247;
            pnlOriginal.Width := 439;
            ebOutputDir.Enabled := true;
            cbIncludeInJSONFile.Enabled := true;
            ebFilename.Enabled := true;
          finally
            Free;
          end;
        end;
      end;
      ObjToForm(fFormData)
    end
  finally
    sl.Free;
    json := nil;
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
    ScanDisk;
  Screen.Cursor := crHourGlass;
  cblFiles.Items.BeginUpdate;
  badFilenames := TStringList.Create;
  try
    if (fWorkingDir <> ebStartPath.Text) or
       (Sender <> ebStartPath) then begin
      CheckStartOk(Sender);
      fWorkingDir := ebStartPath.Text;
      cblFiles.Items.Clear;
      ClearConfigList;
      for filename in fFilenameList do begin
        if (not filename.Contains('!')) and
           (LowerCase(filename).EndsWith('.jpg') or LowerCase(filename).EndsWith('.jpeg')) then begin
          if (fFilterSizeKB <= 0) or
             (SizeOfFileKB(filename) >= fFilterSizeKB) then begin
            if fFormData.DeepScan or fDrapAndDropping then
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
      imageLoaded := LoadSelectedFromFile;
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

procedure TFrmMain.LoadImage(const AJPEG: TJPEGImage; const AImage: TImage);
var
  scale: integer;
  jsScale: TJPEGScale;
  function SizeOfJPEG(const AJPEG: TJPEGImage): uInt64;
  var
    ms: TMemoryStream;
  begin
    ms := TMemoryStream.Create;
    try
      AJPEG.SaveToStream(ms);
      result := Round(ms.Size / cBytesToKB);
    finally
      ms.Free;
    end;
  end;
  procedure SetLabels;
  begin
    AJPEG.Scale := jsFullSize;
    if AJPEG = fJPEGCompressor.JPEGOriginal then begin
      lbImgOrigWidthVal.Caption := AJPEG.Width.ToString;
      lbImgOrigHeightVal.Caption := AJPEG.Height.ToString;
      lbImgOrigSizeKBVal.Caption := SizeOfJPEG(AJPEG).ToString;
    end;
    if (not cbCompressPreview.Checked) or
       (AJPEG <> fJPEGCompressor.JPEGOriginal) then begin
      lbImgWidthVal.Caption := AJPEG.Width.ToString;
      lbImgHeightVal.Caption := AJPEG.Height.ToString;
      lbImgSizeKBVal.Caption := SizeOfJPEG(AJPEG).ToString;
    end;
  end;
begin
  if Assigned(AJPEG) and
     Assigned(AImage) and
     (not fFormCreating) then begin
    try
      try
        AJPEG.Scale := jsHalf; //switching scale forces update which shows the compressed version
        if miApplyBestFit.Checked then begin  //Set scale (reduces shrink artifacting at a low cost)
          SetLabels;
          scale := integer(AJPEG.Scale);
          while (scale <= 3) and
                ((AJPEG.Width > (AImage.Width+oversizeAllowance)) or
                 (AJPEG.Height > (AImage.Height+oversizeAllowance))) do begin
            jsScale := TJPEGScale(scale);
            AJPEG.Scale := jsScale;
            Inc(scale);
          end;
        end else
          SetLabels;
      finally
        if Assigned(AJPEG) then
          AImage.Picture.Assign(AJPEG);
      end;
    except
      on e: exception do
        MessageDlg(e.Message, mtError, mbOKCancel, 0)
    end;
  end;
end;

procedure TFrmMain.miApplyBestFitClick(Sender: TObject);
begin
  miApplyBestFit.Checked := not miApplyBestFit.Checked;
  Screen.Cursor := crHourGlass;
  try
    LoadImage(fJPEGCompressor.JPEG, imgHome);
    LoadImage(fJPEGCompressor.JPEGOriginal, imgOriginal);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.miAutoPrefixClick(Sender: TObject);
begin
  miAutoPrefix.Checked := not miAutoPrefix.Checked;
  fFormData.AutoPrefix := miAutoPrefix.Checked;
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
  FormToObj;
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
    replacingOriginals := fFormData.ReplaceOriginals or (ExtractFilePath(ebStartPath.Text) = ExtractFilePath(ebOutputDir.Text));
    if ((not replacingOriginals) or
       (mrYes = MessageDlg('Outputing to the source directory will result in the original .jpg(s) becoming overwritten.'+#13+#10+
                           'Are you sure you want to overwrite the original images? ', mtWarning, [mbYes, mbNo], 0))) and
        ValidSelection(Sender) then begin
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
          ProcessFile(filename)
        else begin
          for filename in fFilenameList do begin
            if fFormData.DeepScan or (not fDirectoryScanned) then begin
              if (cblFiles.Items.IndexOf(filename) >= 0) and
                 (cblFiles.Checked[cblFiles.Items.IndexOf(filename)]) then
                ProcessFile(filename);
            end else begin
              if (cblFiles.Items.IndexOf(ExtractFileName(filename)) >= 0) and
                 (cblFiles.Checked[cblFiles.Items.IndexOf(ExtractFileName(filename))]) then
                ProcessFile(filename);
            end;
          end;
        end;
        if cbIncludeInJSONFile.Checked then
          CreateJSONFile(fJSON);
        if runScript then
          RunDeploymentScript;
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
        if fFormData.ReplaceOriginals then
          LoadImagePreview(fSelectedFilename);
        if runScript then
          pcMain.ActivePage := tsLogs;
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
        LoadImage(fJPEGCompressor.JPEGOriginal, imgHome)
      else if cbCompressPreview.Checked then begin
        if cbCompress.Checked or cbApplyGraphics.Checked then
          LoadCompressedPreview(Sender)
        else if Assigned(Sender) and (Sender=cbCompressPreview) or
                ((not cbCompress.Checked) and (not cbApplyGraphics.Checked)) then
          LoadImage(fJPEGCompressor.JPEGOriginal, imgHome);
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
  btnStart.Enabled := (FileIsSelected or fImageChanged) and
                      (cbIncludeInJSONFile.Checked or cbCompress.Checked or cbApplyGraphics.Checked) and
                      ((ExtractFilePath(ebStartPath.Text) <> '') and (ExtractFilePath(ebOutputDir.Text) <> ''));
end;

procedure TFrmMain.miClearFilesClick(Sender: TObject);
begin
  ebStartPath.Text := '';
  fFilenameList.Clear;
  Scan(Sender);
end;

procedure TFrmMain.ClearConfigList;
var
  key: string;
begin
  for key in fImageConfigList.Keys do
    fImageConfigList.Items[key].Free;
  fImageConfigList.Clear;
end;

procedure TFrmMain.CloseApplication1Click(Sender: TObject);
begin
  if MessageDlg(cMsgClosingApp, TMsgDlgType.mtConfirmation, mbOKCancel, 0) = mrOK then
    Close;
end;

procedure TFrmMain.CreateJSONFile(const AJSON: ISuperObject);
var
  newfilename: string;
begin
  if Trim(ebFilename.Text) <> '' then begin
    newfilename := IncludeTrailingPathDelimiter(Trim(fOutputDir))+Trim(ebFilename.Text);
    if FileExists(newfilename) then
      DeleteFile(newfilename);
    ForceDirectories(ExtractFilePath(newfilename));
    if cbIncludeInJSONFile.Checked and
       (AJSON.AsArray.Count > 0) then
      AJSON.SaveTo(newfilename, true);
  end;
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
        ToggleScriptLog;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFrmMain.miPurchaseLicenseClick(Sender: TObject);
begin
  OpenURL(cGumRoadLink);
end;

procedure TFrmMain.miRefreshClick(Sender: TObject);
begin
  Scan(Sender);
end;

procedure TFrmMain.miReplaceOriginalsClick(Sender: TObject);
begin
  miReplaceOriginals.Checked := not miReplaceOriginals.Checked;
  fFormData.ReplaceOriginals := miReplaceOriginals.Checked;
  if ValidSelection(Sender) then begin
    ebOutputDir.Enabled := not fFormData.ReplaceOriginals;
    ebFilename.Enabled := not fFormData.ReplaceOriginals;
    cbIncludeInJSONFile.Enabled := not fFormData.ReplaceOriginals;
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
      LoadFormSettings(true);
    finally
      if (oldStartPath <> ebStartPath.Text) or
         (oldDeepScan <> miDeepScan.Checked) then
        Scan(Sender);
    end;
  end;
end;

procedure TFrmMain.OpenURL(const AURL: string);
var
  url: string;
begin
  url := StringReplace(AURL, '"', '%22', [rfReplaceAll]);
  ShellExecute(0, 'open', PChar(url), nil, nil, SW_SHOWNORMAL);
end;

procedure TFrmMain.pcMainChange(Sender: TObject);
begin
  ToggleScriptLog;
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
  if fFormData.AutoPrefix then
    SetPrefixDir(ebOutputDir.Text);
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

procedure TFrmMain.ProcessFile(const AFilename: string);
begin
  fStartTime := Now;
  try
    fFilename := AFilename;
    fSelectedFilename := fFilename;
    LoadImageConfig(fFilename);
    if cbApplyToAll.Checked then
      FormToObj;
    if Assigned(fImageConfig) and
       (fImageConfig.Compress or
        fImageConfig.ApplyGraphics) then begin
      with TJPEGCompressor.Create do begin
        try
          Compress := fImageConfig.Compress;
          ApplyGraphics := fImageConfig.ApplyGraphics;
          CompressionQuality := fImageConfig.Quality;
          TargetKB := fImageConfig.TargetKB;
          OutputDir := ebOutputDir.Text;
          ShrinkByHeight := not fImageConfig.ShrinkByWidth;
          ShrinkByMaxPx := fImageConfig.ShrinkByValue;
          ResampleMode := fImageConfig.ResampleMode;
          RotateAmount := fImageConfig.RotateAmount;
          ReplaceOriginal := fFormData.ReplaceOriginals;
          Process(AFilename);
          fTotalSavedKB := fTotalSavedKB + (OriginalFileSize - CompressedFileSize);
          if fImageConfig.AddToJSON and
             FileExists(AFilename) then
            AddToJSONFile(OriginalFileSize, CompressedFileSize);
          fMessages.Add(Messages.Text);
        finally
          Free;
        end;
      end;
      fEndTime := Now;
    end;
    Inc(fNumProcessed);
  except
    on e: Exception do
      fMessages.Add(e.Classname+': '+e.Message);
  end;
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
        LoadImage(fJPEGCompressor.JPEG, imgHome);
      if not cbStretchOriginal.Checked then
        LoadImage(fJPEGCompressor.JPEGOriginal, imgOriginal);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFrmMain.RunDeploymentScript;
begin
  if FileExists(cShellScript) then begin
    if not fScriptVariables.LoadSavedSettings then begin
      if fScriptVariables.OutputPath = '' then
        fScriptVariables.OutputPath := ebOutputDir.Text;
      if fScriptVariables.SourcePrefix = '' then
        fScriptVariables.SourcePrefix := ebPrefix.Text;
    end;
    fScriptVariables.OutputLines := mmScript.Lines;
    fScriptVariables.RunScript;
  end;
end;

procedure TFrmMain.ScanDisk;
var
  filenames: TStringDynArray;
  dlgProgress: TDlgProgress;
  filename: string;
begin
  dlgProgress := TDlgProgress.Create(Self);
  try
    fFilenameList.Clear;
    if fFormData.DeepScan then begin
      dlgProgress.Text := cMsgScanningDisk;
      dlgProgress.Show;
      Application.ProcessMessages;
    end;
    try
      if ebStartPath.Text <> '' then begin
        if fFormData.DeepScan then
          filenames := TDirectory.GetFiles(ebStartPath.Text, cJPAllExt, TSearchOption.soAllDirectories)
        else
          filenames := TDirectory.GetFiles(ebStartPath.Text, cJPAllExt, TSearchOption.soTopDirectoryOnly);
        for filename in filenames do
          fFilenameList.Add(filename);
      end;
      if (not fFormOpenClose) and
         (fFilenameList.Count = 0) then
        MessageDlg('No images found.', mtWarning, mbOKCancel, 0);
      fDirectoryScanned := true;
    except
      on e: exception do
        MessageDlg(e.Message, mtError, mbOKCancel, 0)
    end;
  finally
    dlgProgress.Free;
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
  with TFileOpenDialog.Create(nil) do begin
    try
      DefaultFolder := ebStartPath.Text;
      Options := [fdoFileMustExist];
      FileTypes.Add.FileMask := cJpgExt;
      if Execute then begin
        imgHome.Align := alNone;
        fWorkingDir := ExtractFilePath(FileName);
        fSelectedFilename := Filename;
        ebStartPath.Text := fWorkingDir;
        cblFiles.Clear;
        cblFiles.Items.Add(ExtractFileName(fSelectedFilename));
        if cblFiles.Items.Count > 0 then begin
          cblFiles.Checked[0] := true;
          btnStart.Enabled := cbCompress.Checked or cbApplyGraphics.Checked or cbIncludeInJSONFile.Checked;
          if btnStart.Enabled and
             cbCompressPreview.Checked then
            LoadCompressedPreview(Sender)
          else
            LoadImagePreview(fSelectedFilename);
        end else
          LoadImagePreview(fSelectedFilename);
        SetControlState(FileExists(fSelectedFilename));
      end;
    finally
      Free;
      imgHome.Align := alClient;
    end;
  end;
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

function TFrmMain.SizeOfFileKB(const AFilename: string): uInt64;
var
  sr : TSearchRec;
begin
  {$WARNINGS OFF} //Specific for Windows
  if FindFirst(AFilename, faAnyFile, sr ) = 0 then
    result := Round(Int64(sr.FindData.nFileSizeHigh) shl Int64(32) + Int64(sr.FindData.nFileSizeLow) / 1024)
  else
    result := 0;
  {$WARNINGS ON}
 FindClose(sr);
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

procedure TFrmMain.ToggleScriptLog(const AStartup: boolean=false);
begin
  if AStartup then begin
    spScript.Visible := false;
    pnlScript.Visible := false;
    mmScript.Lines.Clear;
  end else begin
    pnlScript.Visible := fRunScript;
    spScript.Visible := fRunScript;
  end;
end;

function TFrmMain.ValidSelection(Sender: TObject): boolean;
var
  sl: TStringList;
  hasTargetKB, hasResampling, hasMultipleImages, hasReplaceOriginals: boolean;
begin
  sl := TStringList.Create;
  try
    if (Sender <> miReplaceOriginals) and
       (not FileIsSelected) then
      MessageDlg(cBatchProcessEvaluation, mtError, mbOKCancel, 0)
    else if fEvaluationMode then begin
      HasPayWallConfig(hasTargetKB, hasResampling, hasMultipleImages, hasReplaceOriginals);
      if hasReplaceOriginals then
        sl.Add(cReplaceOrigEval);
      if hasMultipleImages then
        sl.Add(cBatchProcessingEval);
      if hasTargetKB then
        sl.Add(cTargetEval);
      if hasResampling then
        sl.Add(cResamplingEval);
      if sl.Count = 1 then
        sl.CommaText := sl.CommaText.Replace('• ', '');
      if sl.Count > 0 then begin
        sl.Add(' ');
        sl.Add(cLinkToBuyMessage);
      end;
    end;
    result := sl.Count = 0;
    if not result then begin
      if fEvaluationMode and (MessageDlg(sl.Text, mtWarning, mbOKCancel, 0) = mrOk) then begin
        OpenURL(cGumRoadLink);
        miEnterLicenseClick(nil);
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure TFrmMain.cblFilesClick(Sender: TObject);
begin
  inherited;
  if (GetSelectedFileName <> '') and
     (fImageChanged) then begin
    cbCompressPreview.Checked := false;
    LoadSelectedFromFile;
    cbCompressClick(Sender);
    cbApplyGraphicsClick(Sender);
    if fImageChanged then
      btnApply.Enabled := true;
    cblFilesClickCheck(Sender);
  end;
end;

procedure TFrmMain.cblFilesClickCheck(Sender: TObject);
begin
  btnStart.Enabled := FileIsSelected;
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
  SaveFormSettings;
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
    LoadImage(fJPEGCompressor.JPEG, imgHome);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.cbStretchOriginalClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    imgOriginal.Stretch := cbStretchOriginal.Checked;
    LoadImage(fJPEGCompressor.JPEGOriginal, imgHome);
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


