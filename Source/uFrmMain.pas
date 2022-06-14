unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, uJPEGCompressor,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Samples.Spin, SuperObject, Vcl.ComCtrls, Vcl.Menus,
  Vcl.CheckLst, System.IOUtils, System.Types, System.UITypes, DateUtils, ShellApi,
  Vcl.Buttons, Generics.Collections, Img32.Panels, uImageConfig, uLicenseValidator;

const
  oversizeAllowance=75;
  cPayPalDonateLink = 'https://www.paypal.me/TurboImageCompressor';
  cGumRoadLink = 'https://kyleotoole.gumroad.com/l/ticw';
  cActivatedCaption = 'Turbo Image Compressor - Pro';
  cEvaluationCaption = 'Turbo Image Compressor - Free';

type
  TFrmMain = class(TForm)
    pcMain: TPageControl;
    tsHome: TTabSheet;
    tsLogs: TTabSheet;
    pnlMain: TPanel;
    Panel2: TPanel;
    mmMessages: TMemo;
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
    cbDeepScan: TCheckBox;
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
    mmFile: TMainMenu;
    File1: TMenuItem;
    mmiScan: TMenuItem;
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
    cbCreateJSONFile: TCheckBox;
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
    procedure btnStartClick(Sender: TObject);
    procedure seTargetKBsChange(Sender: TObject);
    procedure cbCompressClick(Sender: TObject);
    procedure cbCreateJSONFileClick(Sender: TObject);
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
    procedure ebStartPathExit(Sender: TObject);
    procedure ebStartPathKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CheckCompressPreviewLoad(Sender: TObject=nil);
    procedure seMaxWidthPxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seMaxHeightPxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seTargetKBsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seQualityKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ShowFolderSelect(Sender: TObject);
    procedure ShowFileSelect(Sender: TObject);
    procedure cbStretchClick(Sender: TObject);
    procedure miHideConfigClick(Sender: TObject);
    procedure miHideFilesClick(Sender: TObject);
    procedure ebStartPathChange(Sender: TObject);
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
  private
    { Private declarations }
    fEvaluationMode: boolean;
    fFormClosing,
    fLoadingPreview: boolean;
    fJSON: ISuperObject;
    fWorkingDir: string;
    fFilename: string;
    fNumProcessed: integer;
    fMessages: TStringList;
    fOutputDir: string;
    fStartTime,
    fEndTime: TDateTime;
    fTotalSavedKB: Int64;
    fFilenames: TStringDynArray;
    fJPEGCompressor: TJPEGCompressor;
    fSelectedFilename: string;
    fImageConfig: TImageConfig;
    fImageConfigList: TDictionary<string, TImageConfig>;
    fLoading: boolean;
    fLicenseValidator: TLicenseValidator;
    fFormCreating: boolean;
    procedure HasPayWallConfig(out AHasTargetKB, AHasResampling, AHasMultipleImages: boolean);
    procedure OpenURL(const AURL: string);
    function ValidSelection: boolean;
    procedure ResizeEvent;
    procedure CheckHideLabels;
    procedure LoadImage(const AJPEG: TJPEGImage; const AImage: TImage);
    procedure LoadImageConfig(const AFilename: string);
    function FormToObj(const AImageConfig: TImageConfig=nil): TImageConfig;
    procedure ObjToForm;
    procedure SetControlState(const AEnabled: boolean);
    procedure SetChildControlES(const AParentControl: TControl; const AEnabled: Boolean);
    procedure LoadImagePreview(const AFilename: string); overload;
    procedure LoadSelectedFromFile(const ALoadForm: boolean=true);
    function FileIsSelected: boolean;
    function SelectedFileCount: integer;
    function SizeOfFile(const AFilename: string): Int64;
    procedure Scan;
    procedure ScanDisk;
    procedure AddToJSONFile;
    procedure ProcessFile(const AFilename: string);
    procedure CreateJSONFile(const AJSON: ISuperObject);
    procedure ClearConfigList;
    procedure SetEvaluationMode(const Value: boolean);
  public
    { Public declarations }
    property EvaluationMode: boolean read fEvaluationMode write SetEvaluationMode;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

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

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fFormClosing := true;
  inherited;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  inherited;
  fFormCreating := true;
  fLoadingPreview := false;
  fJPEGCompressor := TJPEGCompressor.Create;
  fEvaluationMode := true;
  fLicenseValidator := TLicenseValidator.Create;
  fImageConfigList := TDictionary<string, TImageConfig>.Create;
  fMessages := TStringList.Create;
  fFormClosing := false;
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
  fOutputDir := IncludeTrailingPathDelimiter(fWorkingDir)+'Compressed\';
  ebOutputDir.Text := fOutputDir;
  pcMain.ActivePage := tsHome;
  Width := 1445;
  Height := 731;
  spOriginal.Left := 784;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  try
    ClearConfigList;
    fImageConfigList.Free;
    fMessages.Free;
    fJPEGCompressor.Free;
    fLicenseValidator.Free;
    fJSON := nil;
  finally
    inherited;
  end;
end;

procedure TFrmMain.FormResize(Sender: TObject);
begin
  if not fFormClosing then
    ResizeEvent;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    mmMessages.Clear;
    pcMain.ActivePage := tsHome;
    ebStartPath.Text := fWorkingDir;
    fFormCreating := false;
  finally
    Screen.Cursor := crDefault;
    Scan;
    inherited;
  end;
end;

function TFrmMain.FormToObj(const AImageConfig: TImageConfig=nil): TImageConfig;
begin
  if fSelectedFilename <> '' then begin
    if Assigned(AImageConfig) then
      result := AImageConfig
    else
      result := fImageConfig;
    with result do begin
      Compress := cbCompress.Checked;
      Quality := seQuality.Value;
      TagetKB := seTargetKBs.Value;
      AddToJSON := cbCreateJSONFile.Checked;
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
    end;
  end else
    result := nil;
end;

procedure TFrmMain.HasPayWallConfig(out AHasTargetKB, AHasResampling, AHasMultipleImages: boolean);
var
  key: string;
  imgConfig: TImageConfig;
begin
  AHasMultipleImages := SelectedFileCount > 1;
  if cbApplyToAll.Checked then begin
    AHasTargetKB := cbCompress.Checked and (seTargetKBs.Value > 0);
    AHasResampling := cbApplyGraphics.Checked and (cbResampleMode.ItemIndex > integer(rmFastest)); //allow fastest
  end else begin
    AHasTargetKB := false;
    AHasResampling := false;
    for key in fImageConfigList.Keys do begin
      if fImageConfigList.TryGetValue(key, imgConfig) then begin
        AHasTargetKB := AHasTargetKB or (imgConfig.Compress and (imgConfig.TagetKB > 0));
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
      fImageConfigList.Add(fSelectedFilename, fImageConfig);
    end;
  end;
  if Assigned(fImageConfig) and fEvaluationMode then
    fImageConfig.ResampleMode := rmFastest;
end;

procedure TFrmMain.ObjToForm;
begin
  fLoading := true;
  try
    if Assigned(fImageConfig) and
      (fSelectedFilename <> '') then begin
      with fImageConfig do begin
        cbCompress.Checked := Compress;
        seQuality.Value := Quality;
        tbQuality.Position := Quality;
        seTargetKBs.Value := TagetKB;
        cbCreateJSONFile.Checked := AddToJSON;
        ebDescription.Text := Description;
        ebPrefix.Text := SourcePrefix;
        cbApplyGraphics.Checked := ApplyGraphics;
        fSelectedFilename := Filename;
        rbByWidth.Checked := ShrinkByWidth;
        rbByHeight.Checked := not ShrinkByWidth;
        cbCompressPreview.Checked := false; //PreviewCompression; it's best not to wait for compression when changing images
        cbStretch.Checked := Stretch;
        cbRotateAmount.ItemIndex := integer(RotateAmount);
        cbResampleMode.ItemIndex := integer(ResampleMode);
        if rbByWidth.Checked then
          seMaxWidthPx.Value := ShrinkByValue
        else
          seMaxHeightPx.Value := ShrinkByValue;
        Filename := fSelectedFilename;
      end;
    end;
  finally
    fLoading := false;
  end;
end;

procedure TFrmMain.LoadCompressedPreview(Sender: TObject);
var
  stretch: boolean;
begin
  if cbCompress.Checked or
     cbApplyGraphics.Checked then begin
    Screen.Cursor := crHourGlass;
    fLoadingPreview := true;
    stretch := cbStretch.Checked;
    try
      LoadImageConfig(fSelectedFilename);
      fImageConfig := FormToObj;
      if fImageConfig.RecordModified or (Sender = cbCompressPreview) or
         (fJPEGCompressor.SourceFilename <> fSelectedFilename) then begin
        fJPEGCompressor.OutputDir := ebOutputDir.Text;
        fJPEGCompressor.Compress := fImageConfig.Compress;
        fJPEGCompressor.ApplyGraphics := fImageConfig.ApplyGraphics;
        fJPEGCompressor.CompressionQuality := fImageConfig.Quality;
        fJPEGCompressor.TargetKB := fImageConfig.TagetKB;
        fJPEGCompressor.ShrinkByHeight := not fImageConfig.ShrinkByWidth;
        fJPEGCompressor.ShrinkByMaxPx := fImageConfig.ShrinkByValue;
        fJPEGCompressor.ResampleMode := fImageConfig.ResampleMode;
        fJPEGCompressor.RotateAmount := fImageConfig.RotateAmount;
        fJPEGCompressor.Process(fSelectedFilename, false);
      end;
    finally
      cbStretch.Checked := false;
      LoadImage(fJPEGCompressor.JPEG, imgHome);
      lbImgSizeKBVal.Caption := fJPEGCompressor.CompressedFilesize.ToString;
      lbImgWidthVal.Caption := fJPEGCompressor.ImageWidth.ToString;
      lbImgHeightVal.Caption := fJPEGCompressor.ImageHeight.ToString;
      seQuality.Value := fJPEGCompressor.JPEG.CompressionQuality;
      tbQuality.Position := seQuality.Value;
      cbStretch.Checked := stretch;
      Screen.Cursor := crDefault;
      fLoadingPreview := false;
    end;
  end;
end;

procedure TFrmMain.LoadImagePreview(const AFilename: string);
begin
  if (AFilename <> '') and Assigned(fJPEGCompressor) then begin
    Screen.Cursor := crHourGlass;
    try
      fJPEGCompressor.JPEG.Scale := jsFullsize;
      fJPEGCompressor.JPEG.LoadFromFile(AFilename);
      lbImgWidthVal.Caption := fJPEGCompressor.JPEG.Width.ToString;
      lbImgHeightVal.Caption := fJPEGCompressor.JPEG.Height.ToString;
      lbImgSizeKBVal.Caption := SizeOfFile(AFilename).ToString;
      LoadImage(fJPEGCompressor.JPEG, imgHome);
      if imgOriginal.Visible then begin
        fJPEGCompressor.JPEGOriginal.Scale := jsFullsize;
        fJPEGCompressor.JPEGOriginal.LoadFromFile(AFilename);
        lbImgOrigWidthVal.Caption := fJPEGCompressor.JPEGOriginal.Width.ToString;
        lbImgOrigHeightVal.Caption := fJPEGCompressor.JPEGOriginal.Height.ToString;
        lbImgOrigSizeKBVal.Caption := SizeOfFile(AFilename).ToString;
        LoadImage(fJPEGCompressor.JPEGOriginal, imgOriginal);
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

{ If DevExpress is installed, force the use of TdxSmartImage Graphic. This result in better image quality
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

procedure TFrmMain.LoadSelectedFromFile(const ALoadForm: boolean=true);
var
  a: integer;
begin
  try
    Screen.Cursor := crHourGlass;
    try
      if fSelectedFilename = '' then begin
        for a := 0 to cblFiles.Count-1 do begin
          if cblFiles.Selected[a] then begin
            fSelectedFilename := IncludeTrailingPathDelimiter(ebStartPath.Text)+cblFiles.Items[a];
            LoadImagePreview(fSelectedFilename);
            Break;
          end;
        end;
      end else
        LoadImagePreview(fSelectedFilename);
      if ALoadForm then begin
        LoadImageConfig(fSelectedFilename);
        ObjToForm;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  except
    on e: exception do
      MessageDlg(e.Classname+' '+e.message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmMain.mniSelectAllClick(Sender: TObject);
var
  a: integer;
begin
  for a := 0 to cblFiles.Count-1 do
    cblFiles.Checked[a] := true;
  btnStart.Enabled := (cblFiles.Count > 0) and (cbCreateJSONFile.Checked or cbCompress.Checked or cbApplyGraphics.Checked);
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

procedure TFrmMain.miEnterLicenseClick(Sender: TObject);
var
  licenseKey, currentKey: string;
  isValid: boolean;
begin
  currentKey := fLicenseValidator.GetLicenseKey;
  licenseKey := InputBox('Enter License Key', 'Key:', currentKey);
  if licenseKey <> currentKey then begin
    Screen.Cursor := crHourGlass;
    try
      fLicenseValidator.LicenseKey := licenseKey;
      isValid := fLicenseValidator.LicenseIsValid;
      if EvaluationMode then
        EvaluationMode := not isValid;
      if not fEvaluationMode then
        MessageDlg(fLicenseValidator.Message, TMsgDlgType.mtInformation, [mbOk], 0)
      else
        MessageDlg(fLicenseValidator.Message, TMsgDlgType.mtError, [mbOk], 0);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFrmMain.AddToJSONFile;
begin
  with fJSON.AsArray do begin
    Add(NewJSONObject);
    O[Count-1].jString['original'] := fImageConfig.SourcePrefix+ExtractFileName(fImageConfig.Filename);
    O[Count-1].jString['description'] := fImageConfig.Description;
  end;
  fMessages.Add('Added '+ExtractFileName(fImageConfig.Filename)+' to JSON file')
end;

procedure TFrmMain.Scan;
var
  filename: string;
  a,
  okCount: integer;
begin
  ScanDisk;
  Screen.Cursor := crHourGlass;
  okCount := 0;
  cblFiles.Items.BeginUpdate;
  try
    cblFiles.Items.Clear;
    ClearConfigList;
    for filename in fFilenames do begin
      if not filename.Contains('!') then begin
        if cbDeepScan.Checked then
          cblFiles.Items.Add(filename)
        else
          cblFiles.Items.Add(ExtractFileName(filename));
        cblFiles.Checked[cblFiles.Count-1] := false;
      end else
        fMessages.Add('Error: Unsupported filename '+filename+': contains ''!'' ');
    end;
    if cblFiles.Count > 0 then begin
      for a := 0 to cblFiles.Count-1 do begin
        try
          if ExtractFilePath(cblFiles.Items[a]) <> '' then
            fSelectedFilename := cblFiles.Items[a]
          else
            fSelectedFilename := IncludeTrailingPathDelimiter(ebStartPath.Text)+cblFiles.Items[a];
          LoadSelectedFromFile;
          Inc(okCount);
          Break;
        except
          on e: exception do begin
            cblFiles.Checked[a] := false;
            fMessages.Add('Error processing '+cblFiles.Items[a]+': '+e.Classname+' raised: '+e.Message);
          end;
        end;
      end;
    end;
  finally
    mmMessages.Lines.Add(fMessages.Text);
    fMessages.Clear;
    cbApplyToAll.Checked := true;
    btnStart.Enabled := false;
    SetControlState(okCount > 0);
    cblFiles.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.LoadImage(const AJPEG: TJPEGImage; const AImage: TImage);
var
  scale: integer;
  jsScale: TJPEGScale;
begin
  if Assigned(AJPEG) and
     Assigned(AImage) and
     (not fFormCreating) then begin
    jsScale := AJPEG.Scale;
    try
      //involke change so compression quality preview shows accurately
      if AJPEG.Scale <> jsFullSize then
        AJPEG.Scale := jsFullSize
      else
        AJPEG.Scale := jsEighth;
      //Set scale for improved image quality
      if miApplyBestFit.Checked then begin
        scale := integer(jsFullSize);
        AJPEG.Scale := jsFullSize;
        while (scale <= 3) and
              ((AJPEG.Width > (AImage.Width+oversizeAllowance)) or
               (AJPEG.Height > (AImage.Height+oversizeAllowance))) do begin
          jsScale := TJPEGScale(scale);
          AJPEG.Scale := jsScale;
          Inc(scale);
        end;
      end;
    finally
      AJPEG.Scale := jsScale;
      AImage.Picture.Assign(AJPEG);
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

procedure TFrmMain.btnApplyClick(Sender: TObject);
begin
  FormToObj;
  if Assigned(fImageConfig) then
    fImageConfig.RecordModified := false;
  btnApply.Enabled := false;
  cbApplyToAll.Checked := false;
end;

procedure TFrmMain.btnScanClick(Sender: TObject);
begin
  Scan;
end;

procedure TFrmMain.btnStartClick(Sender: TObject);
var
  filename: string;
begin
  fJSON := TSuperObject.Create(stArray);
  btnStart.Enabled := false;
  try
    if ((ExtractFileName(ebStartPath.Text) = '') or
        (ExtractFilePath(ebStartPath.Text) <> ExtractFilePath(ebOutputDir.Text)) or
        (mrYes = MessageDlg('Outputing to the source directory will result in the original .jpg(s) becoming overwritten.'+#13+#10+
                           'Are you sure you want to continue? ', mtWarning, [mbYes, mbNo], 0))) and ValidSelection then begin
      Screen.Cursor := crHourGlass;
      try
        fOutputDir := IncludeTrailingPathDelimiter(ebOutputDir.Text);
        fTotalSavedKB := 0;
        fNumProcessed := 0;
        mmMessages.Lines.BeginUpdate;
        fMessages.Add('--------------------- Start ---------------------------');
        filename := ebStartPath.Text;
        if LowerCase(ExtractFileExt(filename)) = '.jpg' then
          ProcessFile(filename)
        else begin
          filename := ExtractFilePath(filename);
          ScanDisk;
          for filename in fFilenames do begin
            if (cblFiles.Items.IndexOf(ExtractFileName(filename)) >= 0) and
               (cblFiles.Checked[cblFiles.Items.IndexOf(ExtractFileName(filename))]) then
              ProcessFile(filename);
          end;
        end;
        if cbCreateJSONFile.Checked then
          CreateJSONFile(fJSON);
      finally
        if fNumProcessed = 0 then
          MessageDlg('No .jpg files processed', mtWarning, [mbOK], 0)
        else if (cbApplyGraphics.Checked or cbCompress.Checked) then begin
          fMessages.Add('Finished processing '+fNumProcessed.ToString+' .jpg files. ');
          fMessages.Add('Total saved (KB): '+fTotalSavedKB.ToString);
          MessageDlg('Finished processing '+fNumProcessed.ToString+' .jpg files. '+sLineBreak+
                     'Total saved (KB): '+fTotalSavedKB.ToString, mtInformation, [mbOK], 0);
        end else begin
          fMessages.Add('Finished processing '+fNumProcessed.ToString+' .jpg files. ');
          MessageDlg('Finished processing '+fNumProcessed.ToString+' .jpg files. ', mtInformation, [mbOK], 0);
        end;
        fMessages.Add('--------------------- End -------------------------');
        mmMessages.Lines.Add(fMessages.Text);
        Screen.Cursor := crDefault;
      end;
    end;
  finally
    fJSON := nil;
    mmMessages.Lines.EndUpdate;
    btnStart.Enabled := true;
  end;
end;

procedure TFrmMain.CheckCompressPreviewLoad(Sender: TObject=nil);
begin
  if not fLoading then begin
    Screen.Cursor := crHourGlass;
    try
      if (Sender = cbCompressPreview) and (not cbCompressPreview.Checked) then
        LoadSelectedFromFile(false)
      else if cbCompressPreview.Checked then begin
        if cbCompress.Checked or cbApplyGraphics.Checked then
          LoadCompressedPreview(Sender)
        else if Assigned(Sender) and (Sender=cbCompressPreview) or
                ((not cbCompress.Checked) and (not cbApplyGraphics.Checked)) then
          LoadSelectedFromFile(false);
        cbStretch.Enabled := cbCompressPreview.Enabled;
      end;
      btnApply.Enabled := true;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFrmMain.CheckHideLabels;
const
  previewMaxWidth=525;
  origMaxWidth=425;
begin
  cbStretchOriginal.Visible := false;
  try
    lbImgSizeKB.Visible := pnlImage.Width >= previewMaxWidth;
    lbImgSizeKBVal.Visible := pnlImage.Width >= previewMaxWidth;
    lbImgWidth.Visible := pnlImage.Width >= previewMaxWidth;
    lbImgWidthVal.Visible := pnlImage.Width >= previewMaxWidth;
    lbImgHeight.Visible := pnlImage.Width >= previewMaxWidth;
    lbImgHeightVal.Visible := pnlImage.Width >= previewMaxWidth;
    lbImgOrigSize.Visible := pnlOriginal.Width >= origMaxWidth;
    lbImgOrigSizeKBVal.Visible := pnlOriginal.Width > origMaxWidth;
    lbImgOrigWidth.Visible := pnlOriginal.Width > origMaxWidth;
    lbImgOrigWidthVal.Visible := pnlOriginal.Width > origMaxWidth;
    lbImgOrigHeight.Visible := pnlOriginal.Width > origMaxWidth;
    lbImgOrigHeightVal.Visible := pnlOriginal.Width > origMaxWidth;
  finally
    if not cbStretchOriginal.Visible then
      cbStretchOriginal.Visible := true; //workaround painting issues
  end;
end;

procedure TFrmMain.CheckStartOk(Sender: TObject);
begin
  btnStart.Enabled := FileIsSelected and
                      (cbCreateJSONFile.Checked or cbCompress.Checked or cbApplyGraphics.Checked) and
                      ((ExtractFilePath(ebStartPath.Text) <> '') and (ExtractFilePath(ebOutputDir.Text) <> ''));
end;

procedure TFrmMain.ClearConfigList;
var
  key: string;
begin
  for key in fImageConfigList.Keys do
    fImageConfigList.Items[key].Free;
  fImageConfigList.Clear;
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
    if cbCreateJSONFile.Checked and
       (AJSON.AsArray.Count > 0) then
      AJSON.SaveTo(newfilename, true);
  end;
end;

procedure TFrmMain.miPurchaseLicenseClick(Sender: TObject);
begin
  OpenURL(cGumRoadLink);
end;

procedure TFrmMain.OpenURL(const AURL: string);
var
  url: string;
begin
  url := StringReplace(AURL, '"', '%22', [rfReplaceAll]);
  ShellExecute(0, 'open', PChar(url), nil, nil, SW_SHOWNORMAL);
end;

procedure TFrmMain.ebDescriptionChange(Sender: TObject);
begin
  btnApply.Enabled := true;
end;

procedure TFrmMain.ebPrefixChange(Sender: TObject);
begin
  btnApply.Enabled := true;
end;

procedure TFrmMain.ebStartPathChange(Sender: TObject);
begin
  CheckStartOk(Sender);
  fWorkingDir := ebStartPath.Text;
end;

procedure TFrmMain.ebStartPathExit(Sender: TObject);
begin
  Scan;
end;

procedure TFrmMain.ebStartPathKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vkReturn then
    Scan;
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
    if fImageConfig.AddToJSON then
      AddToJSONFile;
    if Assigned(fImageConfig) and
       (fImageConfig.Compress or
        fImageConfig.ApplyGraphics) then begin
      with TJPEGCompressor.Create do begin
        try
          Compress := fImageConfig.Compress;
          ApplyGraphics := fImageConfig.ApplyGraphics;
          CompressionQuality := fImageConfig.Quality;
          TargetKB := fImageConfig.TagetKB;
          OutputDir := ebOutputDir.Text;
          ShrinkByHeight := not fImageConfig.ShrinkByWidth;
          ShrinkByMaxPx := fImageConfig.ShrinkByValue;
          ResampleMode := fImageConfig.ResampleMode;
          RotateAmount := fImageConfig.RotateAmount;
          Process(AFilename);
          fTotalSavedKB := fTotalSavedKB + (OriginalFileSize - CompressedFileSize);
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
  Scan;
end;

procedure TFrmMain.ResizeEvent;
begin
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

procedure TFrmMain.ScanDisk;
begin
  if cbDeepScan.Checked then
    TDirectory.GetFiles(ebStartPath.Text, '*.jpg', TSearchOption.soAllDirectories)
  else
    fFilenames := TDirectory.GetFiles(ebStartPath.Text, '*.jpg', TSearchOption.soTopDirectoryOnly);
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
  lbFiles.Enabled := AEnabled;
  cbCompressPreview.Enabled := AEnabled;
  cbStretch.Enabled := AEnabled;
  imgHome.Enabled := AEnabled;
end;

procedure TFrmMain.SetEvaluationMode(const Value: boolean);
begin
  fEvaluationMode := Value;
  miPurchaseLicense.Enabled := fEvaluationMode;
  if fEvaluationMode then
    Caption := cEvaluationCaption
  else
    Caption := cActivatedCaption;
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
    CheckCompressPreviewLoad;
    CheckStartOk(Sender);
  end;
end;
{$WARNINGS OFF} //Specific for Windows
procedure TFrmMain.ShowFolderSelect(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do begin
    try
      DefaultFolder := fWorkingDir;
      Options := [fdoPickFolders];
      if Execute then begin
        fWorkingDir := FileName;
        ebStartPath.Text := fWorkingDir;
        Scan;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFrmMain.miHideFilesClick(Sender: TObject);
begin
  pnlFiles.Visible := not pnlFiles.Visible;
  miHideFiles.Checked := not pnlFiles.Visible;
end;

procedure TFrmMain.miHideOriginalClick(Sender: TObject);
begin
  miHideOriginal.Checked := not miHideOriginal.Checked;
  pnlOriginal.Visible := not miHideOriginal.Checked;
  spOriginal.Visible := not miHideOriginal.Checked;
end;

procedure TFrmMain.ShowFileSelect(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do begin
    try
      DefaultFolder := ebStartPath.Text;
      Options := [fdoFileMustExist];
      FileTypes.Add.FileMask := '*.jpg';
      if Execute then begin
        imgHome.Align := alNone;
        fWorkingDir := ExtractFilePath(FileName);
        fSelectedFilename := Filename;
        ebStartPath.Text := fWorkingDir;
        cblFiles.Clear;
        cblFiles.Items.Add(ExtractFileName(fSelectedFilename));
        if cblFiles.Items.Count > 0 then begin
          cblFiles.Checked[0] := true;
          btnStart.Enabled := cbCompress.Checked or cbApplyGraphics.Checked or cbCreateJSONFile.Checked;
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
    seTargetKBs.Enabled := cbCompress.Checked;
    lbQuality.Enabled := cbCompress.Checked;
    lbTargetKB.Enabled := cbCompress.Checked;
    tbQuality.Enabled := cbCompress.Checked;
    CheckCompressPreviewLoad;
    CheckStartOk(Sender);
  end;
end;

procedure TFrmMain.cbCreateJSONFileClick(Sender: TObject);
begin
  ebPrefix.Enabled := cbCreateJSONFile.Checked;
  lbPrefix.Enabled := cbCreateJSONFile.Checked;
  lbDescription.Enabled := cbCreateJSONFile.Checked;
  ebDescription.Enabled := cbCreateJSONFile.Checked; 
  CheckStartOk(Sender);
end;

function TFrmMain.SizeOfFile(const AFilename: string): Int64;
var
  sr : TSearchRec;
begin
  {$WARNINGS OFF} //Specific for Windows
  if FindFirst(AFilename, faAnyFile, sr ) = 0 then
    result := Round(Int64(sr.FindData.nFileSizeHigh) shl Int64(32) + Int64(sr.FindData.nFileSizeLow) / 1024)
  else
    result := -1;
  {$WARNINGS ON}
 FindClose(sr);
end;

procedure TFrmMain.spOriginalMoved(Sender: TObject);
begin
  ResizeEvent;
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

function TFrmMain.ValidSelection: boolean;
var
  sl: TStringList;
  hasTargetKB, hasResampling, hasMultipleImages: boolean;
begin
  sl := TStringList.Create;
  try
    if not FileIsSelected then
      MessageDlg('• Please select at least one image to process', mtError, mbOKCancel, 0)
    else if fEvaluationMode then begin
      HasPayWallConfig(hasTargetKB, hasResampling, hasMultipleImages);
      if hasMultipleImages then
        sl.Add('• Batch image processing is not available in the free version. Please process one image at time.');
      if hasTargetKB then
        sl.Add('• Target (KB) is not available in the free version.');
      if hasResampling then
        sl.Add('• The selected resampling mode is not available in the free version.');
      if sl.Count > 0 then begin
        sl.Add(' ');
        sl.Add('Would you like to purchase the Pro version in order to avail of these exclusive features?');
      end;
    end;
    result := sl.Count = 0;
    if not result then begin
      if fEvaluationMode and (MessageDlg(sl.Text, mtWarning, mbOKCancel, 0) = mrOk) then
        OpenURL(cGumRoadLink);
    end;
  finally
    sl.Free;
  end;
end;

procedure TFrmMain.cblFilesClick(Sender: TObject);
var
  oldfilename: string;
  oldObj: TImageConfig;
begin
  inherited;
  oldfilename := fSelectedFilename;
  fSelectedFilename := '';
  cbCompressPreview.Checked := false;
  oldObj := fImageConfig;
  LoadSelectedFromFile;
  CheckCompressPreviewLoad;
  cbCompressClick(nil);
  cbApplyGraphicsClick(nil);
  if Assigned(oldObj) and
     oldObj.RecordModified and
     (oldfilename <> fSelectedFilename) then
    oldObj.Reset;
end;

procedure TFrmMain.cblFilesClickCheck(Sender: TObject);
begin
  btnStart.Enabled := FileIsSelected and
                      (cbCreateJSONFile.Checked or cbCompress.Checked or cbApplyGraphics.Checked);
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

procedure TFrmMain.miShowOriginalClick(Sender: TObject);
begin
  pnlOriginal.Visible := not pnlOriginal.Visible;
  spOriginal.Visible := pnlOriginal.Visible;
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
    if cbStretch.Checked then begin
      fJPEGCompressor.JPEG.Scale := jsFullSize;
      imgHome.Picture.Assign(fJPEGCompressor.JPEG);
    end;
    LoadImage(fJPEGCompressor.JPEG, imgHome);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.cbStretchOriginalClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    if cbStretchOriginal.Checked then begin
      fJPEGCompressor.JPEGOriginal.Scale := jsFullSize;
      imgOriginal.Picture.Assign(fJPEGCompressor.JPEGOriginal);
    end else
      LoadImage(fJPEGCompressor.JPEGOriginal, imgOriginal);
    imgOriginal.Stretch := cbStretchOriginal.Checked;
  finally
    Screen.Cursor := crDefault;
  end;
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
end;

procedure TFrmMain.seTargetKBsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = vkReturn then
    CheckCompressPreviewLoad(Sender);
end;

end.


