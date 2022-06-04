unit uFrmJPGFileCompress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, uJPEGCompressor,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Samples.Spin, SuperObject, Vcl.ComCtrls, Vcl.Menus,
  Vcl.CheckLst, System.IOUtils, System.Types, System.UITypes, DateUtils,
  Vcl.Buttons, Generics.Collections, Img32.Panels, uImageConfig;

const
  oversizeAllowance=75;

type
  TFrmMain = class(TForm)
    pcMain: TPageControl;
    tsHome: TTabSheet;
    tsResults: TTabSheet;
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
    cbShrink: TCheckBox;
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
    mmiShowConfig: TMenuItem;
    seMaxWidthPx: TSpinEdit;
    seMaxHeightPx: TSpinEdit;
    mmiShowFiles: TMenuItem;
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
    lbImgSizeOrigKBVal: TLabel;
    lbImgOrigWidth: TLabel;
    lbImgOrigWidthVal: TLabel;
    lbImgOrigHeight: TLabel;
    lbImgOrigHeightVal: TLabel;
    cbStretchOriginal: TCheckBox;
    spOriginal: TSplitter;
    Label5: TLabel;
    miShowOriginal: TMenuItem;
    miApplyBestFit: TMenuItem;
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
    procedure mmiShowConfigClick(Sender: TObject);
    procedure mmiShowFilesClick(Sender: TObject);
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
    procedure pmPreviewPopup(Sender: TObject);
    procedure cbShrinkClick(Sender: TObject);
    procedure spOriginalMoved(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miApplyBestFitClick(Sender: TObject);
  private
    { Private declarations }
    fFormClosing: boolean;
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
    procedure ApplyBestFit(const AJPEG: TJPEGImage; const AImage: TImage);
    procedure LoadImageConfig(const AFilename: string);
    function FormToObj(const AImageConfig: TImageConfig=nil): TImageConfig;
    procedure ObjToForm;
    procedure SetControlState(const AEnabled: boolean);
    procedure SetChildControlES(const AParentControl: TControl; const AEnabled: Boolean);
    procedure LoadCompressedPreview;
    procedure LoadImagePreview(const AFilename: string); overload;
    procedure LoadSelectedFromFile(const ALoadForm: boolean=true);
    function FileIsSelected: boolean;
    function SizeOfFile(const AFilename: string): Int64;
    procedure Scan;
    procedure ScanDisk;
    procedure AddToJSONFile;
    procedure ProcessFile(const AFilename: string);
    procedure CreateJSONFile(const AJSON: ISuperObject);
    procedure ClearConfigList;
  public
    { Public declarations }
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
  fJPEGCompressor := TJPEGCompressor.Create;
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
  ClientWidth := 1434;
  ClientHeight := 731;
  spOriginal.Left := 783;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  try
    ClearConfigList;
    fImageConfigList.Free;
    fMessages.Free;
    fJPEGCompressor.Free;
  finally
    inherited;
  end;
end;

procedure TFrmMain.FormResize(Sender: TObject);
begin
  if not fFormClosing then begin
    Screen.Cursor := crHourGlass;
    try
      ApplyBestFit(fJPEGCompressor.JPEG, imgHome);
      ApplyBestFit(fJPEGCompressor.JPEGOriginal, imgOriginal);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  ebStartPath.Text := fWorkingDir;
  mmMessages.Clear;
  Scan;
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
      Shrink := cbShrink.Checked;
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
        cbShrink.Checked := Shrink;
        fSelectedFilename := Filename;
        rbByWidth.Checked := ShrinkByWidth;
        rbByHeight.Checked := not ShrinkByWidth;
        cbCompressPreview.Checked := fImageConfig.PreviewCompression;
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

procedure TFrmMain.pmPreviewPopup(Sender: TObject);
begin
  if pnlOriginal.Visible then
    miShowOriginal.Caption := 'Hide Original'
  else
    miShowOriginal.Caption := 'Show Original';
end;

procedure TFrmMain.LoadCompressedPreview;
begin
  if cbCompress.Checked or
     cbShrink.Checked then begin
    Screen.Cursor := crHourGlass;
    try
      LoadImageConfig(fSelectedFilename);
      fImageConfig := FormToObj;
      if fImageConfig.RecordModified or
         (fJPEGCompressor.SourceFilename <> fSelectedFilename) then begin
        fJPEGCompressor.OutputDir := ebOutputDir.Text;
        fJPEGCompressor.Compress := fImageConfig.Compress;
        fJPEGCompressor.Shrink := fImageConfig.Shrink;
        fJPEGCompressor.CompressionQuality := fImageConfig.Quality;
        fJPEGCompressor.TargetKB := fImageConfig.TagetKB;
        fJPEGCompressor.ShrinkByHeight := not fImageConfig.ShrinkByWidth;
        fJPEGCompressor.ShrinkByMaxPx := fImageConfig.ShrinkByValue;
        fJPEGCompressor.ResampleMode := fImageConfig.ResampleMode;
        fJPEGCompressor.RotateAmount := fImageConfig.RotateAmount;
        fJPEGCompressor.Process(fSelectedFilename, false);
        ApplyBestFit(fJPEGCompressor.JPEG, imgHome);
        lbImgSizeKBVal.Caption := fJPEGCompressor.CompressedFilesize.ToString;
        lbImgWidthVal.Caption := fJPEGCompressor.ImageWidth.ToString;
        lbImgHeightVal.Caption := fJPEGCompressor.ImageHeight.ToString;
      end;
    finally
      ApplyBestFit(fJPEGCompressor.JPEG, imgHome);
      Screen.Cursor := crDefault;
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
      ApplyBestFit(fJPEGCompressor.JPEG, imgHome);
      if imgOriginal.Visible then begin
        fJPEGCompressor.JPEGOriginal.Scale := jsFullsize;
        fJPEGCompressor.JPEGOriginal.LoadFromFile(AFilename);
        lbImgOrigWidthVal.Caption := fJPEGCompressor.JPEGOriginal.Width.ToString;
        lbImgOrigHeightVal.Caption := fJPEGCompressor.JPEGOriginal.Height.ToString;
        lbImgSizeOrigKBVal.Caption := SizeOfFile(AFilename).ToString;
        ApplyBestFit(fJPEGCompressor.JPEGOriginal, imgOriginal);
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

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
  btnStart.Enabled := (cblFiles.Count > 0) and (cbCreateJSONFile.Checked or cbCompress.Checked or cbShrink.Checked);
end;

procedure TFrmMain.mniUnSelectAllClick(Sender: TObject);
var
  a: integer;
begin
  for a := 0 to cblFiles.Count-1 do
    cblFiles.Checked[a] := false;
  btnStart.Enabled := false;
end;

procedure TFrmMain.mmiShowConfigClick(Sender: TObject);
begin
  pnlConfig.Visible := not pnlConfig.Visible;
  if not pnlConfig.Visible then
    mmiShowConfig.Caption := 'Show Config'
  else
    mmiShowConfig.Caption := 'Hide Confg';
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
        cblFiles.Checked[cblFiles.Count-1] := true;
      end else
        fMessages.Add('Error: Unsupported filename '+filename+': contains ''!'' ');
    end;
    btnStart.Enabled := false;
    if cblFiles.Count > 0 then begin
      for a := 0 to cblFiles.Count-1 do begin
        try
          if not cblFiles.Items[a].Contains('!') then begin
            fSelectedFilename := IncludeTrailingPathDelimiter(ebStartPath.Text)+cblFiles.Items[a];
            LoadSelectedFromFile;
            Inc(okCount);
            Break;
          end;
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
    btnStart.Enabled := (okCount > 0) and (cbCreateJSONFile.Checked or cbCompress.Checked or cbShrink.Checked);
    SetControlState(okCount > 0);
    cblFiles.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.ApplyBestFit(const AJPEG: TJPEGImage; const AImage: TImage); //improves load times and image quality (by reducing the amount the image gets squashed down)
var
  scale: integer;
begin
  if Assigned(AJPEG) and
     Assigned(AImage) then begin
    AJPEG.Scale := jsFullsize;
    if miApplyBestFit.Checked then begin
      scale := 1;
      while (scale <= 3) and
            ((AJPEG.Width > (AImage.Width+oversizeAllowance)) or
             (AJPEG.Height > (AImage.Height+oversizeAllowance))) do begin
        AJPEG.Scale := TJPEGScale(scale);
        Inc(scale);
      end;
    end;
    AImage.Picture.Assign(AJPEG);
  end;
end;

procedure TFrmMain.miApplyBestFitClick(Sender: TObject);
begin
  miApplyBestFit.Checked := not miApplyBestFit.Checked;
  Screen.Cursor := crHourGlass;
  try
    ApplyBestFit(fJPEGCompressor.JPEG, imgHome);
    ApplyBestFit(fJPEGCompressor.JPEGOriginal, imgOriginal);
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
    if (ExtractFileName(ebStartPath.Text) = '') or
       (ExtractFilePath(ebStartPath.Text) <> ExtractFilePath(ebOutputDir.Text)) or
       (mrYes = MessageDlg('Outputing to the source directory will result in the original .jpg(s) becoming overwritten.'+#13+#10+
                           'Are you sure you want to continue? ', mtWarning, [mbYes, mbNo], 0)) then begin
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
        else if (cbShrink.Checked or cbCompress.Checked) then begin
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
        if cbCompress.Checked or cbShrink.Checked then
          LoadCompressedPreview
        else if Assigned(Sender) and (Sender=cbCompressPreview) or
                ((not cbCompress.Checked) and (not cbShrink.Checked)) then
          LoadSelectedFromFile(false);
        cbStretch.Enabled := cbCompressPreview.Enabled;
      end;
      btnApply.Enabled := true;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFrmMain.CheckStartOk(Sender: TObject);
begin
  btnStart.Enabled := FileIsSelected and
                      (cbCreateJSONFile.Checked or cbCompress.Checked or cbShrink.Checked) and
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
        fImageConfig.Shrink) then begin
      with TJPEGCompressor.Create do begin
        try
          Compress := fImageConfig.Compress;
          Shrink := fImageConfig.Shrink;
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

procedure TFrmMain.ScanDisk;
begin
  if cbDeepScan.Checked then
    TDirectory.GetFiles(ebStartPath.Text, '*.jpg', TSearchOption.soAllDirectories)
  else
    fFilenames := TDirectory.GetFiles(ebStartPath.Text, '*.jpg', TSearchOption.soTopDirectoryOnly);
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

procedure TFrmMain.SetShrinkState(Sender: TObject);
begin
  if not fLoading then begin
    rbByWidth.Enabled := cbShrink.Checked;
    rbByHeight.Enabled := cbShrink.Checked;
    seMaxWidthPx.Enabled := rbByWidth.Enabled and rbByWidth.Checked;
    lbMaxWidthPx.Enabled := rbByWidth.Enabled and rbByWidth.Checked;
    seMaxHeightPx.Enabled := rbByHeight.Enabled and rbByHeight.Checked;
    lbMaxHeightPx.Enabled := rbByHeight.Enabled and rbByHeight.Checked;
    cbResampleMode.Enabled := cbShrink.Checked;
    cbRotateAmount.Enabled := cbShrink.Checked;
    lbResampling.Enabled := cbShrink.Checked;
    lbRotation.Enabled := cbShrink.Checked;
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

procedure TFrmMain.mmiShowFilesClick(Sender: TObject);
begin
  pnlFiles.Visible := not pnlFiles.Visible;
  if pnlFiles.Visible then begin
    pnlFiles.Width := 177;
    mmiShowFiles.Caption := 'Hide JPEG(S) Found';
  end else
    mmiShowFiles.Caption := 'Show JPEG(S) Found';
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
          btnStart.Enabled := cbCompress.Checked or cbShrink.Checked or cbCreateJSONFile.Checked;
          if btnStart.Enabled and
             cbCompressPreview.Checked then
            LoadCompressedPreview
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
  Screen.Cursor := crHourGlass;
  try
    ApplyBestFit(fJPEGCompressor.JPEG, imgHome);
    ApplyBestFit(fJPEGCompressor.JPEGOriginal, imgOriginal);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.tbQualityChange(Sender: TObject);
begin
  CheckCompressPreviewLoad(Sender);
  seQuality.Value := tbQuality.Position;
end;

procedure TFrmMain.tbQualityKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    CheckCompressPreviewLoad(Sender);
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
  cbShrinkClick(nil);
  if Assigned(oldObj) and
     oldObj.RecordModified and
     (oldfilename <> fSelectedFilename) then
    oldObj.Reset;
end;

procedure TFrmMain.cblFilesClickCheck(Sender: TObject);
begin
  btnStart.Enabled := FileIsSelected and
                      (cbCreateJSONFile.Checked or cbCompress.Checked or cbShrink.Checked);
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

procedure TFrmMain.cbShrinkClick(Sender: TObject);
begin
  CheckCompressPreviewLoad(Sender);
  rbByWidth.Enabled := cbShrink.Checked;
  rbByHeight.Enabled := cbShrink.Checked;
  seMaxWidthPx.Enabled := rbByWidth.Enabled and rbByWidth.Checked;
  lbMaxWidthPx.Enabled := rbByWidth.Enabled and rbByWidth.Checked;
  seMaxHeightPx.Enabled := rbByHeight.Enabled and rbByHeight.Checked;
  lbMaxHeightPx.Enabled := rbByHeight.Enabled and rbByHeight.Checked;
  cbResampleMode.Enabled := cbShrink.Checked;
  cbRotateAmount.Enabled := cbShrink.Checked;
  lbResampling.Enabled := cbShrink.Checked;
  lbRotation.Enabled := cbShrink.Checked;
end;

procedure TFrmMain.cbStretchClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    if cbStretch.Checked then begin
      fJPEGCompressor.JPEG.Scale := jsFullSize;
      imgHome.Picture.Assign(fJPEGCompressor.JPEG);
    end else
      ApplyBestFit(fJPEGCompressor.JPEG, imgHome);
    imgHome.Stretch := cbStretch.Checked;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.cbStretchOriginalClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    if cbStretch.Checked then begin
      fJPEGCompressor.JPEG.Scale := jsFullSize;
      imgOriginal.Picture.Assign(fJPEGCompressor.JPEGOriginal);
    end else
      ApplyBestFit(fJPEGCompressor.JPEGOriginal, imgOriginal);
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


