unit uMainController;

interface

uses
  System.Classes, System.SysUtils, SuperObject, uImageConfig, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Forms, Vcl.Dialogs, REST.JSON, Vcl.Controls,
  Winapi.ShellAPI, WinApi.Windows, System.IOUtils, System.Types, uDlgProgress, uDynamicScript, System.Generics.Collections,
  uMainModel, uFormData, uLicenseValidator, Vcl.StdCtrls, Vcl.ComCtrls, uJPEGCompressor;

type
  TMainController = class(TObject)
  strict private
    fMainModel: TMainModel;
    fMainView: TComponent;
    fLoadingPreview: boolean;
    fMessages: TStringList;
    fNumProcessed: integer;
    fTotalSavedKB: uInt64;
    fStartTime,
    fEndTime: TDateTime;
    fOutputDir: string;
    fWorkingDir: string;
    fLicenseValidator: TLicenseValidator;
    fFilterSizeKB: uInt64;
    fThumbnailSizePx: integer;
    fImageChanged: boolean;
    fRunScript: boolean;
    fDragAndDropping: boolean;
    fFormData: TFormData;
    fDynamicScript: TDynamicScript;
    fImageConfig: TImageConfig;
    fImageConfigList: TDictionary<string, TImageConfig>;
    fJSON: ISuperObject;
    fSelectedFilename: string;
    fJPEGCompressor: TJPEGCompressor;
    fOrigPnlGlobalsWidth,
    fOrigPnlIncludeFileWidth,
    fOrigPnlCompressionWidth: integer;
    fPersistFilename: string;
    function AddPath(const AFilename: string): string;
    function ValidFormSelection: boolean;
    procedure LoadImageConfig(const AFilename: string);
    procedure HasPayWallConfig(out AHasRotation, AHasResampling, AHasMultipleImages, AHasReplaceOriginals, AHasScript: boolean);
    procedure AddToJSONFile(const AOriginalFileSize: Int64; const ACompressedFileSize: Int64; const AThumbnailFilename: string='');
    procedure LoadCompressedPreview(Sender: TObject);
    procedure ApplyResponsiveLogic(Sender: TObject);
    procedure ClearImagePreviewLabels;
  public
    constructor Create(const AOwnerView: TComponent);
    destructor Destroy; override;
    procedure ScanDisk;
    procedure CheckAddPath;
    procedure AddMissingPaths;
    procedure Scan(Sender: TObject; const AClearItems: boolean=true);
    procedure ShowDlgThumbnailSize(Sender: TObject);
    procedure QualityRadioClick(Sender: TObject);
    procedure Refresh(Sender: TObject);
    procedure OpenWith(Sender: TObject);
    procedure CheckListPopup(Sender: TObject);
    procedure OpenSelectedExplorer(Sender: TObject);
    procedure OpenSelectedImage(Sender: TObject);
    procedure QualityChange(Sender: TObject);
    procedure ClearFilesClick(Sender: TObject);
    procedure ViewsPopup(Sender: TObject);
    procedure SetControlState(const AEnabled: boolean);
    procedure SetChildControlES(const AParentControl: TControl; const AEnabled: Boolean);
    procedure TargetFilesizeChange(Sender: TObject);
    procedure HideFilesClick(Sender: TObject);
    procedure HideOriginalClick(Sender: TObject);
    procedure CompressClick(Sender: TObject);
    procedure IncludeInFileClick(Sender: TObject);
    procedure DeepScanClick(Sender: TObject);
    procedure ShowEnterLicenseKey(Sender: TObject);
    procedure ShowFileSizeFilter(Sender: TObject);
    procedure SetShrinkState(Sender: TObject);
    procedure FilesClick(Sender: TObject);
    procedure StretchClick(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure ApplyGraphicsClick(Sender: TObject);
    procedure FullScreenClick(Sender: TObject);
    procedure CheckCompressPreviewLoad(Sender: TObject);
    procedure RestoreDefaults(Sender: TObject);
    procedure ShowDeploymentScript(Sender: TObject);
    procedure ReplaceOriginals(Sender: TObject);
    procedure ResizeEvent(Sender: TObject);
    procedure OpenURL(const AURL: string);
    procedure ClearConfigList;
    procedure SaveFormSettings;
    procedure RunDeploymentScript;
    procedure CreateJSONFile(const AJSON: ISuperObject);
    procedure LoadImagePreview(const AFilename: string); overload;
    procedure ToggleScriptLog(const AStartup: boolean=false);
    procedure ProcessFile(const AFilename: string);
    procedure LoadFormSettings(const ARestoreDefaults: boolean=false);
    procedure LoadImage(const ALoadCompressed: boolean; const AImage: TImage; const AApplyBestFit: boolean);
    procedure CheckHideLabels;
    procedure ObjToForm(AImageConfig: TImageConfig=nil; const AOnlyFormData: boolean=false);
    function FormToObj(const AImageConfig: TImageConfig=nil): TImageConfig;
    function ShowFolderSelect(Sender: TObject): string;
    function GetSelectedFilename: string;
    function ShowFileSelect(Sender: TObject): string;
    function ValidSelection(Sender: TObject): boolean;
    function AllowStart: boolean;
    function FileIsSelected: boolean;
    function LoadSelectedFromFile(const ALoadForm: boolean=true): boolean;
    function SizeOfFileKB(const AFilename: string): uInt64;
    property DragAndDropping: boolean read fDragAndDropping write fDragAndDropping;
    property MainView: TComponent read fMainView write fMainView;
    property FormData: TFormData read fFormData write fFormData;
    property ImageConfig: TImageConfig read fImageConfig;
    property RunScript: boolean read fRunScript;
    property ImageChanged: boolean read fImageChanged;
    property SelectedFilename: string read fSelectedFilename write fSelectedFilename;
    property FilterSizeKB: uInt64 read fFilterSizeKB write fFilterSizeKB;
    property OutputDir: string read fOutputDir;
    property WorkingDir: string read fWorkingDir;
  end;

implementation

uses
  System.UITypes, uFrmMain, uConstants, uFrmShellScript, DateUtils, uDlgFilter, uDlgThumbnailSize;

  function OwnerView(const AOwner: TComponent): TFrmMain;
  begin
    if Assigned(AOwner) and (AOwner is TFrmMain) then
      result := TFrmMain(AOwner)
    else
      raise Exception.Create(cUnSupportedClassType);
  end;

{TMainController}

constructor TMainController.Create(const AOwnerView: TComponent);
begin
  inherited Create;
  if not (AOwnerView is TFrmMain) then
    raise Exception.Create(cUnSupportedClassType)
  else
    fMainView := AOwnerView;
  fMainModel := TMainModel.Create(Self);
  with OwnerView(fMainView) do begin
    fOrigPnlGlobalsWidth := pnlGlobals.Width;
    fOrigPnlIncludeFileWidth := pnlIncludeInFile.Width;
    fOrigPnlCompressionWidth := pnlCompression.Width;
    seTargetKBs.Enabled := false;
  end;
  fDynamicScript := TDynamicScript.Create(AOwnerView);
  fMessages := TStringList.Create;
  fNumProcessed := 0;
  fTotalSavedKB := 0;
  fFilterSizeKB := 0;
  fSelectedFilename := '';
  fPersistFilename := '';
  fWorkingDir := TPath.GetPicturesPath;
  fThumbnailSizePx := cDefaultThumbnailMaxSizePx;
  fOutputDir := IncludeTrailingPathDelimiter(fWorkingDir)+cDefaultOutDir;
  fJPEGCompressor := TJPEGCompressor.Create;
  fLicenseValidator := TLicenseValidator.Create;
  fImageChanged := true;
  fRunScript := false;
  fDragAndDropping := false;
  fFormData := TFormData.Create;
  fImageConfigList := TDictionary<string, TImageConfig>.Create;
  ToggleScriptLog(true);
  {$IFDEF DEBUG} //Show window size in realtime
  TFrmMain(fMainView).lbClientWidth.Visible := true;
  TFrmMain(fMainView).lbClientHeight.Visible := true;
  {$ENDIF}
end;

destructor TMainController.Destroy;
begin
  try
    if Assigned(fFormData) then
      fFormData.Free;
    if Assigned(fMainModel) then
      fMainModel.Free;
    if Assigned(fImageConfigList) then
      fImageConfigList.Free;
    if Assigned(fDynamicScript) then
      fDynamicScript.Free;
    if Assigned(fLicenseValidator) then
      fLicenseValidator.Free;
    if Assigned(fJPEGCompressor) then
      fJPEGCompressor.Free;
    if Assigned(fMessages) then
      fMessages.Free;
  finally
    inherited;
  end;
end;

procedure TMainController.DeepScanClick(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    if EvaluationMode then begin
      if MessageDlg(cDeepScanEval+sLineBreak+sLineBreak+cLinkToBuyMessage, mtWarning, mbOKCancel, 0) = mrOk then
        OpenURL(cGumRoadLink);
    end else begin
      miDeepScan.Checked := not miDeepScan.Checked;
      FormData.DeepScan := miDeepScan.Checked;
      Scan(Sender);
    end;
  end;
end;

procedure TMainController.ShowDeploymentScript(Sender: TObject);
begin
  with TFrmShellScript.Create(fMainView) do begin
    try
      with OwnerView(fMainView) do begin
        OutputPath := ebOutputDir.Text;
        SourcePrefix := ebPrefix.Text;
        EvaluationMode := OwnerView(fMainView).EvaluationMode;
        RunOnCompletion := fRunScript;
      end;
      ShowModal;
      if RecordModified then begin
        if fFormData.ReplaceOriginals and
           RunOnCompletion then
          MessageDlg(cMsgScriptWillNotRun, mtWarning, mbOKCancel, 0);
        fRunScript := RunOnCompletion;
        ToggleScriptLog;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TMainController.ShowEnterLicenseKey(Sender: TObject);
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
        OwnerView(fMainView).EvaluationMode := true;
      end else begin
        fLicenseValidator.LicenseKey := newKey;
        if fLicenseValidator.LicenseKey <> '' then begin
          isValid := fLicenseValidator.LicenseIsValid;
          if OwnerView(fMainView).EvaluationMode then
            OwnerView(fMainView).EvaluationMode := not isValid;
        end;
      end;
    finally
      Screen.Cursor := crDefault;
      if (msg <> '') and OwnerView(fMainView).EvaluationMode then
        MessageDlg(msg, TMsgDlgType.mtError, [mbOk], 0)
      else if fLicenseValidator.Message <> '' then
        MessageDlg(fLicenseValidator.Message, TMsgDlgType.mtInformation, [mbOk], 0);
    end;
  end;
end;

function TMainController.AddPath(const AFilename: string): string;
begin
  result := AFilename;
  if ExtractFilePath(result) = '' then
    result := IncludeTrailingPathDelimiter(OwnerView(fMainView).ebStartPath.Text)+result;
end;

function TMainController.ShowFileSelect(Sender: TObject): string;
var
  a,
  idxExisting: integer;
  fileOpenDlg: TFileOpenDialog;
begin
  result := '';
  idxExisting := -1;
  fileOpenDlg := TFileOpenDialog.Create(fMainView);
  try
    try
      with fileOpenDlg, OwnerView(fMainView) do begin
        FileTypes.Add.FileMask := cJpgExt;
        FileTypes.Add.FileMask := cJpegExt;
        DefaultFolder := ebStartPath.Text;
        Options := [fdoFileMustExist, fdoAllowMultiSelect];
        if Execute then begin
          cbCompressPreview.Checked := false;
          fWorkingDir := ExtractFilePath(FileName);
          result := Filename;
          CheckAddPath;
          OwnerView(fMainView).imgHome.Picture.Assign(nil);
          OwnerView(fMainView).imgOriginal.Picture.Assign(nil);
          ClearImagePreviewLabels;
          SetControlState(false);
          if FileExists(result) then begin
            btnStart.Enabled := cbCompress.Checked or cbApplyGraphics.Checked or cbIncludeInJSONFile.Checked;
            for a := 0 to Files.Count-1 do begin
              idxExisting := cblFiles.Items.IndexOf(Files.Strings[a]);
              if idxExisting = -1 then
                cblFiles.Items.Insert(0, (Files.Strings[a]));
            end;
            if idxExisting >= 0 then begin
              cblFiles.Selected[idxExisting] := true;
              LoadImagePreview(AddPath(cblFiles.Items[idxExisting]));
            end else if Files.Count > 0 then begin
              cblFiles.Selected[Files.Count-1] := true;
              LoadImagePreview(AddPath(cblFiles.Items[Files.Count-1]));
            end;
            SetControlState(true);
          end else begin
            result := '';
            SetControlState(false);
          end;
          cblFiles.SetFocus;
        end;
      end;
    except
      on e: exception do begin
        result := '';
        MessageDlg(e.Classname+' '+e.message, mtError, [mbOK], 0);
      end;
    end;
  finally
    fSelectedFilename := result;
    fileOpenDlg.Free;
  end;
end;

function TMainController.ShowFolderSelect(Sender: TObject): string;
begin
  result := '';
  with TFileOpenDialog.Create(fMainView) do begin
    try
      with OwnerView(fMainView) do begin
        try
          FileTypes.Add.FileMask := cJpgExt;
          FileTypes.Add.FileMask := cJpegExt;
          if Sender = ebOutputDir then
            result := ebOutputDir.Text
          else if Sender = ebStartPath then
            result := ebStartPath.Text
          else if Sender is TEdit then
            result := TEdit(Sender).Text
          else
            result := ebStartPath.Text;
          DefaultFolder := result;
          Options := [fdoPickFolders];
          if Execute then begin
            result := FileName;
            if (Sender = ebOutputDir) or
               (Sender = miSelectOutputDir) then
              ebOutputDir.Text := result
            else begin
              ebStartPath.Text := result;
              Scan(Sender);
            end;
            cblFiles.SetFocus;
          end;
        except
          on e: exception do
            MessageDlg(e.ClassName+' '+e.Message, TMsgDlgType.mtError, [mbOk], 0);
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TMainController.ShowFileSizeFilter(Sender: TObject);
begin
  with TDlgFilter.Create(fMainView) do begin
    try
      Size := fFilterSizeKB;
      ShowModal;
      if RecordModified then begin
        fFilterSizeKB := Size;
        Scan(Sender);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TMainController.CreateJSONFile(const AJSON: ISuperObject);
var
  newfilename: string;
begin
  with OwnerView(fMainView) do begin
    if Trim(ebFilename.Text) <> '' then begin
      newfilename := IncludeTrailingPathDelimiter(Trim(fOutputDir))+Trim(ebFilename.Text);
      if FileExists(newfilename) then
        System.SysUtils.DeleteFile(newfilename);
      ForceDirectories(ExtractFilePath(newfilename));
      if (cbIncludeInJSONFile.Checked) and
         (AJSON.AsArray.Count > 0) then
        AJSON.SaveTo(newfilename, true);
    end;
  end;
end;

procedure TMainController.ObjToForm(AImageConfig: TImageConfig=nil; const AOnlyFormData: boolean=false);
var
  imageConfig: TImageConfig;
begin
  with OwnerView(fMainView) do begin
    Loading := true;
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
            ebTitle.Text := Title;
            cbApplyGraphics.Checked := ApplyGraphics;
            fSelectedFilename := Filename;
            rbByWidth.Checked := ShrinkByWidth;
            rbByHeight.Checked := not ShrinkByWidth;
            cbCompressPreview.Checked := false;
            cbStretch.Checked := Stretch;
            rbTarget.Checked := TargetKB > 0;
            rbQuality.Checked := not rbTarget.Checked;
            seTargetKBs.Enabled := rbTarget.Checked and not rbQuality.Checked;
            seQuality.Enabled := not rbTarget.Checked;
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
              fThumbnailSizePx := ThumbnailSizePx;
              pnlFiles.Width := PnlFilesWidth;
              pnlOriginal.Width := PnlOriginalWidth;
              cbApplyToAll.Checked := ApplyToAll;
              ebFilename.Text := JsonFilename;
              ebPrefix.Text := SourcePrefix;
              fRunScript := RunScript;
              cbCreateThumbnails.Checked := CreateThumbnails;
            end;
          end;
        end;
      end;
    finally
      Loading := false;
    end;
  end;
end;

function TMainController.LoadSelectedFromFile(const ALoadForm: boolean=true): boolean;
begin
  try
    Screen.Cursor := crHourGlass;
    try
      with OwnerView(fMainView) do begin
        fImageChanged := true;
        fSelectedFilename := GetSelectedFileName;
        if fSelectedFilename <> '' then
          lbFiles.Caption := 'Selected: '+ExtractFileName(fSelectedFilename)
        else
          lbFiles.Caption := 'Selected: ';
        result := (fSelectedFilename <> '') and FileExists(fSelectedFilename);
        if (fImageChanged) or
           (not result) then //to the image
          LoadImagePreview(fSelectedFilename);
        if ALoadForm and
           fImageChanged then begin
          LoadImageConfig(fSelectedFilename);
          ObjToForm;
        end;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  except
    on e: exception do begin
      MessageDlg(e.Classname+' '+e.message, mtError, [mbOK], 0);
      result := false;
    end;
  end;
end;

function TMainController.AllowStart: boolean;
begin
  with OwnerView(fMainView) do begin
    result := (FileIsSelected or fImageChanged) and
              (cbIncludeInJSONFile.Checked or cbCompress.Checked or cbApplyGraphics.Checked) and
              (ExtractFilePath(ebOutputDir.Text) <> '');
  end;
end;

procedure TMainController.ApplyClick(Sender: TObject);
var
  obj: TImageConfig;
  procedure SelectCurrentImage;
  var
    a: integer;
    filename: string;
  begin
    with OwnerView(fMainView) do begin
      for a := 0 to cblFiles.Items.Count-1 do begin
        filename := AddPath(cblFiles.Items[a]);
        if filename = fSelectedFilename then begin
          cblFiles.Selected[a] := true;
          cblFiles.Checked[a] := true;
          Break;
        end;
      end;
    end;
  end;
begin
  obj := FormToObj;
  if Assigned(obj) then
    obj.FreeOnChange := false;
  SelectCurrentImage;
  if Assigned(fImageConfig) then
    fImageConfig.RecordModified := false;
  OwnerView(fMainView).cbApplyToAll.Checked := false;
  OwnerView(fMainView).btnApply.Enabled := false;
end;

procedure TMainController.ApplyGraphicsClick(Sender: TObject);
begin
  CheckCompressPreviewLoad(Sender);
  with OwnerView(fMainView) do begin
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
end;

procedure TMainController.CheckAddPath;
var
  a: integer;
begin
  with OwnerView(fMainView) do begin
    if (cblFiles.Items.Count >= 1) and
       (ExtractFilePath(cblFiles.Items[0]) = '') then begin
      for a := 0 to cblFiles.Items.Count-1 do
        cblFiles.Items[a] := AddPath(cblFiles.Items[a])
    end;
  end;
end;

procedure TMainController.CheckCompressPreviewLoad(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    if not Loading then begin
      Screen.Cursor := crHourGlass;
      try
        if (Sender <> cbCompressPreview) and
           (Assigned(fImageConfig)) then
          fImageConfig.PreviewModified := true;
        if (Sender = cbCompressPreview) and (not cbCompressPreview.Checked) then
          LoadImage(false, imgHome, miApplyBestFit.Checked)
        else if cbCompressPreview.Checked then begin
          if cbCompress.Checked or cbApplyGraphics.Checked then
            LoadCompressedPreview(Sender)
          else if Assigned(Sender) and (Sender=cbCompressPreview) or
                  ((not cbCompress.Checked) and (not cbApplyGraphics.Checked)) then
            LoadImage(false, imgHome, miApplyBestFit.Checked);
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
end;

procedure TMainController.CheckHideLabels;
begin
  with OwnerView(fMainView) do begin
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
end;

procedure TMainController.CheckListPopup(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    miShowInGallery.Enabled := cblFiles.Count > 0;
    miShowInExplorer.Enabled := cblFiles.Count > 0;
  end;
end;

procedure TMainController.ClearConfigList;
var
  key: string;
begin
  with OwnerView(fMainView) do begin
    for key in fImageConfigList.Keys do
      fImageConfigList.Items[key].Free;
    fImageConfigList.Clear;
  end;
end;

procedure TMainController.ClearFilesClick(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    ebStartPath.Text := '';
    FilenameList.Clear;
    Scan(Sender);
  end;
end;

procedure TMainController.ClearImagePreviewLabels;
begin
  with OwnerView(fMainView) do begin
    lbImgOrigWidthVal.Caption := '0';
    lbImgOrigHeightVal.Caption := '0';
    lbImgOrigSizeKBVal.Caption := '0';
    lbImgWidthVal.Caption := '0';
    lbImgHeightVal.Caption := '0';
    lbImgSizeKBVal.Caption := '0';
  end;
end;

procedure TMainController.CompressClick(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    seQuality.Enabled := cbCompress.Checked and (seTargetKBs.Value = 0);
    tbQuality.Enabled := seQuality.Enabled;
    seTargetKBs.Enabled := cbCompress.Checked and not rbQuality.Checked;
    lbQuality.Enabled := cbCompress.Checked;
    lbTargetKB.Enabled := cbCompress.Checked;
    CheckCompressPreviewLoad(Sender);
    btnStart.Enabled := AllowStart;
  end;
end;

function TMainController.FileIsSelected: boolean;
var
  a: integer;
begin
  result := false;
  with OwnerView(fMainView) do begin
    for a:=0 to cblFiles.Count-1 do begin
      result := cblFiles.Checked[a];
      if result then
        Break;
    end;
  end;
end;

procedure TMainController.FilesClick(Sender: TObject);
begin
  if (GetSelectedFileName <> '') and
     (fImageChanged) then begin
    with OwnerView(fMainView) do begin
      cbCompressPreview.Checked := false;
      LoadSelectedFromFile;
      cbCompressClick(Sender);
      cbApplyGraphicsClick(Sender);
      if fImageConfigList.TryGetValue(fSelectedFilename, fImageConfig) then begin
        if fImageConfig.FreeOnChange then begin
          fImageConfig.Free;
          fImageConfig := nil;
          fImageConfigList.Remove(fSelectedFilename);
        end;
      end;
      if fImageChanged then
        btnApply.Enabled := true;
      cblFilesClickCheck(Sender);
    end;
  end;
end;

procedure TMainController.LoadImageConfig(const AFilename: string);
begin
  with OwnerView(fMainView) do begin
    if fSelectedFilename <> '' then begin
      fImageConfigList.TryGetValue(fSelectedFilename, fImageConfig);
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
        fImageConfig.Title := fFormData.Title;
        fImageConfigList.Add(fSelectedFilename, fImageConfig);
      end;
    end;
    if (Assigned(fImageConfig)) and
       (EvaluationMode) then
      fImageConfig.ResampleMode := rmRecommended;
  end;
end;

procedure TMainController.ProcessFile(const AFilename: string);
begin
  with OwnerView(fMainView) do begin
    fStartTime := Now;
    try
      fSelectedFilename := AFilename;
      LoadImageConfig(AFilename);
      if cbApplyToAll.Checked then
        FormToObj;
      if Assigned(fImageConfig) and
         (fImageConfig.Compress or
          fImageConfig.ApplyGraphics) then begin
        with TJPEGCompressor.Create do begin
          try
            CreateThumbnail := cbCreateThumbnails.Checked;
            ThumbnailSizePx := fThumbnailSizePx;
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
              AddToJSONFile(OriginalFileSize, CompressedFileSize, ThumbnailFilename);
            if Messages.Text <> '' then
              fMessages.Add(Messages.Text);
          finally
            Free;
          end;
        end;
        fEndTime := Now;
        Inc(fNumProcessed);
      end;
    except
      on e: Exception do
        fMessages.Add(e.Classname+': '+e.Message);
    end;
  end;
end;

procedure TMainController.QualityChange(Sender: TObject);
begin
  if not fLoadingPreview then begin
    CheckCompressPreviewLoad(Sender);
    with OwnerView(fMainView) do
      seQuality.Value := tbQuality.Position;
  end;
end;

procedure TMainController.QualityRadioClick(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    seTargetKBs.Enabled := rbTarget.Checked;
    seQuality.Enabled := rbQuality.Checked;
    tbQuality.Enabled := rbQuality.Checked;
    if not seTargetKBs.Enabled then
      seTargetKBs.Value := 0;
    CheckCompressPreviewLoad(Sender);
  end;
end;

procedure TMainController.LoadCompressedPreview(Sender: TObject);
var
  stretch,
  compressionChanged: boolean;
begin
  with OwnerView(fMainView) do begin
    if cbCompress.Checked or
       cbApplyGraphics.Checked then begin
      Screen.Cursor := crHourGlass;
      fLoadingPreview := true;
      stretch := cbStretch.Checked;
      try
        if not Assigned(fImageConfig) then begin
          fImageConfig := TImageConfig.Create;
          fImageConfigList.Add(fSelectedFilename, fImageConfig);
          FormToObj(fImageConfig);
        end;
        if Assigned(fImageConfig) then begin
          compressionChanged := fImageConfig.PreviewModified;
          FormToObj(fImageConfig);
          if (compressionChanged) or
             (fJPEGCompressor.SourceFilename <> fSelectedFilename) then begin
            fJPEGCompressor.OutputDir := ebOutputDir.Text;
            fJPEGCompressor.Compress := fImageConfig.Compress;
            fJPEGCompressor.ApplyGraphics := fImageConfig.ApplyGraphics;
            fJPEGCompressor.CompressionQuality := fImageConfig.Quality;
            fJPEGCompressor.TargetKB := fImageConfig.TargetKB;
            fJPEGCompressor.ShrinkByHeight := not fImageConfig.ShrinkByWidth;
            fJPEGCompressor.ShrinkByMaxPx := fImageConfig.ShrinkByValue;
            fJPEGCompressor.ResampleMode := fImageConfig.ResampleMode;
            fJPEGCompressor.RotateAmount := fImageConfig.RotateAmount;
            fJPEGCompressor.Process(fSelectedFilename, false);
            fImageConfig.PreviewModified := false;
          end else if (not compressionChanged) then begin
            fJPEGCompressor.MemoryStream.Position := 0;
            fJPEGCompressor.JPEG.LoadFromStream(fJPEGCompressor.MemoryStream);
          end;
          fImageConfig.PreviewModified := false;
        end;
      finally
        cbStretch.Checked := false;
        LoadImage(true, imgHome, miApplyBestFit.Checked);
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
      end;
    end;
  end;
end;

procedure TMainController.LoadFormSettings(const ARestoreDefaults: boolean);
begin
  fMainModel.LoadFormSettings(ARestoreDefaults);
end;

procedure TMainController.LoadImage(const ALoadCompressed: boolean; const AImage: TImage; const AApplyBestFit: boolean);
var
  jpeg: TJPEGImage;
  scale: integer;
  jsScale: TJPEGScale;
  function SizeOfJPEG(const jpeg: TJPEGImage): uInt64;
  var
    ms: TMemoryStream;
  begin
    ms := TMemoryStream.Create;
    try
      jpeg.SaveToStream(ms);
      result := Round(ms.Size / cBytesToKB);
    finally
      ms.Free;
    end;
  end;
  procedure SetLabels;
  begin
    with OwnerView(fMainView) do begin
      jpeg.Scale := jsFullSize;
      if jpeg = fJPEGCompressor.JPEGOriginal then begin
        lbImgOrigWidthVal.Caption := jpeg.Width.ToString;
        lbImgOrigHeightVal.Caption := jpeg.Height.ToString;
        lbImgOrigSizeKBVal.Caption := SizeOfJPEG(jpeg).ToString;
      end;
      if (not cbCompressPreview.Checked) or
         (jpeg <> fJPEGCompressor.JPEGOriginal) then begin
        lbImgWidthVal.Caption := jpeg.Width.ToString;
        lbImgHeightVal.Caption := jpeg.Height.ToString;
        lbImgSizeKBVal.Caption := SizeOfJPEG(jpeg).ToString;
      end;
    end;
  end;
  function JPEGLargerThanImageBox: boolean;
  begin
    result := ((jpeg.Width > (AImage.Width + oversizeAllowance)) or
               (jpeg.Height > (AImage.Height + oversizeAllowance)));
  end;
begin
  with OwnerView(fMainView) do begin
    if not FormOpenClose then begin
      if ALoadCompressed then
        jpeg := fJPEGCompressor.JPEG
      else
        jpeg := fJPEGCompressor.JPEGOriginal;
      if Assigned(jpeg) and
         Assigned(AImage) and
         (not FormCreating) then begin
        try
          try
            if (AApplyBestFit) then begin  //Set scale (reduces shrink artifacting at a low cost)
              jpeg.Scale := jsHalf; //switching scale forces update which shows the compressed version
              SetLabels;
              scale := integer(jpeg.Scale);
              while (scale <= 3) and
                    (JPEGLargerThanImageBox) do begin
                jsScale := TJPEGScale(scale);
                jpeg.Scale := jsScale;
                Inc(scale);
              end;
            end else
              SetLabels;
          finally
            if Assigned(jpeg) then
              AImage.Picture.Assign(jpeg);
          end;
        except
          on e: exception do
            MessageDlg(e.Message, mtError, mbOKCancel, 0)
        end;
      end;
    end;
  end;
end;

procedure TMainController.HasPayWallConfig(out AHasRotation, AHasResampling, AHasMultipleImages, AHasReplaceOriginals, AHasScript: boolean);
var
  key: string;
  imgConfig: TImageConfig;
begin
  with OwnerView(fMainView) do begin
    AHasMultipleImages := SelectedFileCount > 1;
    AHasReplaceOriginals := fFormData.ReplaceOriginals;
    AHasScript := fRunScript;
    if cbApplyToAll.Checked then begin
      AHasResampling := cbApplyGraphics.Checked and (cbResampleMode.ItemIndex > integer(rmRecommended)); //allow rmRecommended in demo
      AHasRotation := cbRotateAmount.ItemIndex > integer(raNone);
    end else begin
      AHasResampling := false;
      for key in fImageConfigList.Keys do begin
        if fImageConfigList.TryGetValue(key, imgConfig) then begin
          AHasResampling := AHasResampling or (imgConfig.ApplyGraphics and (imgConfig.ResampleMode <> rmNone));
          AHasRotation := AHasRotation or (imgConfig.ApplyGraphics and (imgConfig.RotateAmount <> raNone));
          if AHasRotation or AHasResampling then
            Break;
        end;
      end;
    end;
  end;
end;

procedure TMainController.HideFilesClick(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    miHideFiles.Checked := not pnlFiles.Visible;
    pnlFiles.Visible := not pnlFiles.Visible;
    miHideFiles.Checked := not pnlFiles.Visible;
    ResizeEvent(Sender);
  end;
end;

procedure TMainController.HideOriginalClick(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    miHideOriginal.Checked := not miHideOriginal.Checked;
    pnlOriginal.Visible := not miHideOriginal.Checked;
    spOriginal.Visible := not miHideOriginal.Checked;
    ResizeEvent(Sender);
  end;
end;

procedure TMainController.IncludeInFileClick(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    ebTitle.Enabled := cbIncludeInJSONFile.Checked;
    lbTitle.Enabled := cbIncludeInJSONFile.Checked;
    lbDescription.Enabled := cbIncludeInJSONFile.Checked;
    ebDescription.Enabled := cbIncludeInJSONFile.Checked;
    btnApply.Enabled := true;
    btnStart.Enabled := AllowStart;
  end;
end;

function TMainController.SizeOfFileKB(const AFilename: string): uInt64;
var
  sr : TSearchRec;
begin
  {$WARNINGS OFF} //Specific for Windows
  if System.SysUtils.FindFirst(AFilename, faAnyFile, sr ) = 0 then
    result := Round(Int64(sr.FindData.nFileSizeHigh) shl Int64(32) + Int64(sr.FindData.nFileSizeLow) / 1024)
  else
    result := 0;
  {$WARNINGS ON}
  System.SysUtils.FindClose(sr);
end;

procedure TMainController.StartClick(Sender: TObject);
var
  currImageConfig: TImageConfig;
  filename,
  durationMsg: string;
  startTime: TDateTime;
  dlgProgrss: TDlgProgress;
  runScript: boolean;
  replacingOriginals, ok: boolean;
  origSelectedFilename: string;
  procedure ReloadSelectedImage;
  begin
    if origSelectedFilename <> '' then begin
      fSelectedFilename := origSelectedFilename;
      LoadImageConfig(fSelectedFilename);
      ObjToForm;
      LoadImagePreview(fSelectedFilename);
    end;
  end;
begin
  with OwnerView(fMainView) do begin
    fJSON := TSuperObject.Create(stArray);
    btnStart.Enabled := false;
    startTime := Now;
    runScript := fRunScript;
    origSelectedFilename := fSelectedFilename;
    fImageConfigList.TryGetValue(fSelectedFilename, currImageConfig);
    try
      if ValidFormSelection then begin
        replacingOriginals := (FormData.ReplaceOriginals) or
                              (IncludeTrailingPathDelimiter(ebStartPath.Text) = IncludeTrailingPathDelimiter(ebOutputDir.Text));
        if replacingOriginals then begin
          ok := mrYes = MessageDlg('Are you sure you want to overwrite the original images? ', mtWarning, [mbYes, mbNo], 0)
        end else
          ok := true;
        if ok and ValidSelection(Sender) then begin
          if (runScript) and
             (not FormData.ReplaceOriginals) and
             (mrYes <> MessageDlg(cMsgDeploymentWarning, mtWarning, [mbYes, mbNo], 0)) then
            runScript := false;
          Screen.Cursor := crHourGlass;
          dlgProgrss := TDlgProgress.Create(fMainView);
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
              for filename in FilenameList do begin
                if FormData.DeepScan or (not DirectoryScanned) then begin
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
            if runScript and not FormData.ReplaceOriginals then
              RunDeploymentScript;
          finally
            dlgProgrss.Free;
            if SecondsBetween(startTime, Now) = 0 then
              durationMsg := 'Total duration (ms): '+MilliSecondsBetween(startTime, Now).ToString
            else
              durationMsg := 'Total duration (s): '+SecondsBetween(startTime, Now).ToString;
            if fNumProcessed = 0 then
              MessageDlg('No .jpg files processed', mtWarning, [mbOK], 0)
            else if (cbApplyGraphics.Checked or cbCompress.Checked) then begin

              fMessages.Add('Finished processing '+fNumProcessed.ToString+' .jpg files. ');
              fMessages.Add('Total saved (KB): '+fTotalSavedKB.ToString);
              MessageDlg('Finished processing '+fNumProcessed.ToString+' .jpg files. '+sLineBreak+
                         'Total saved (KB): '+fTotalSavedKB.ToString+sLineBreak+
                         durationMsg, mtInformation, [mbOK], 0);
            end else begin
              fMessages.Add('Finished processing '+fNumProcessed.ToString+' .jpg files. ');
              MessageDlg('Finished processing '+fNumProcessed.ToString+' .jpg files. '+sLineBreak+
                         durationMsg, mtInformation, [mbOK], 0);
            end;
            fMessages.Add(durationMsg);
            fMessages.Add('--------------------- End -------------------------');
            if Trim(fMessages.Text) <> '' then
              mmMessages.Lines.Add(fMessages.Text);
            mmMessages.Lines.EndUpdate;
            if FormData.ReplaceOriginals then
              LoadImagePreview(fSelectedFilename);
            if runScript then begin
              ToggleScriptLog;
              pcMain.ActivePage := tsLogs;
            end;
            Screen.Cursor := crDefault;
          end;
        end;
      end;
    finally
      fJSON := nil;
      ReloadSelectedImage;
      btnStart.Enabled := true;
    end;
  end;
end;

procedure TMainController.StretchClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    with OwnerView(fMainView) do begin
      if not FormOpenClose then begin
        if Sender = cbStretchOriginal then begin
          imgOriginal.Stretch := cbStretchOriginal.Checked;
          LoadImage(false, imgOriginal, miApplyBestFit.Checked);
        end else begin
          imgHome.Stretch := cbStretch.Checked;
          LoadImage(cbCompressPreview.Checked, imgHome, miApplyBestFit.Checked);
        end;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainController.TargetFilesizeChange(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    seQuality.Enabled := seTargetKBs.Value <= 0;
    tbQuality.Enabled := seQuality.Enabled;
    btnApply.Enabled := true;
  end;
end;

procedure TMainController.ToggleScriptLog(const AStartup: boolean);
begin
  with OwnerView(fMainView) do begin
    if AStartup then begin
      spScript.Visible := false;
      pnlScript.Visible := false;
      mmScript.Lines.Clear;
    end else begin
      pnlScript.Visible := fRunScript;
      spScript.Visible := fRunScript;
    end;
  end;
end;

procedure TMainController.AddMissingPaths;
var
  a: integer;
  imgConfig: TImageConfig;
begin
  with OwnerView(fMainView) do begin
    for a := 0 to cblFiles.Items.Count-1 do begin
      if ExtractFilePath(cblFiles.Items[a]) = '' then begin
        cblFiles.Items[a] := AddPath(cblFiles.Items[a]);
        if fImageConfigList.TryGetValue(ExtractFilename(cblFiles.Items[a]), imgConfig) then begin
          fImageConfigList.Remove(ExtractFilename(cblFiles.Items[a]));
          fImageConfigList.Add(cblFiles.Items[a], imgConfig);
        end;
      end;
    end;
  end;
end;

procedure TMainController.AddToJSONFile(const AOriginalFileSize: Int64; const ACompressedFileSize: Int64; const AThumbnailFilename: string='');
var
  sourcePrefix: string;
begin
  with OwnerView(fMainView) do begin
    with fJSON.AsArray do begin
      Add(NewJSONObject);
      sourcePrefix := ebPrefix.Text;
      if sourcePrefix <> '' then begin
        if (sourcePrefix.Contains('/')) and
           (not sourcePrefix.EndsWith('/')) then
          sourcePrefix := sourcePrefix +'/'
        else if (sourcePrefix.Contains('\')) and
                (not sourcePrefix.EndsWith('\')) then
          sourcePrefix := sourcePrefix + '\';
        sourcePrefix := sourcePrefix;
      end;
      if fImageConfig.Title <> '' then
        O[Count-1].S['title'] := fImageConfig.Title;
      if fImageConfig.Description <> '' then
        O[Count-1].S['description'] := fImageConfig.Description;
      if (AThumbnailFilename <> '') and FileExists(AThumbnailFilename) then
        O[Count-1].S['thumbnail'] := sourcePrefix + ExtractFileName(AThumbnailFilename);
      O[Count-1].S['original'] := sourcePrefix + ExtractFileName(fImageConfig.Filename);
      O[Count-1].I['uncompressedFileSizeKB'] := AOriginalFileSize;
      O[Count-1].I['fileSizeKB'] := ACompressedFileSize;
    end;
    fMessages.Add('Added '+fImageConfig.Filename+' to JSON file')
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

procedure TMainController.LoadImagePreview(const AFilename: string);
begin
  with OwnerView(fMainView) do begin
    if (AFilename <> '') and Assigned(fJPEGCompressor) then begin
      Screen.Cursor := crHourGlass;
      try
        fSelectedFilename := AFilename;
        fJPEGCompressor.JPEG.Scale := jsFullsize;
        fJPEGCompressor.JPEG.LoadFromFile(AFilename);
        LoadImage(true, imgHome, miApplyBestFit.Checked);
        if imgOriginal.Visible then begin
          fJPEGCompressor.JPEGOriginal.Scale := jsFullsize;
          fJPEGCompressor.JPEGOriginal.LoadFromFile(AFilename);
          lbImgOrigWidthVal.Caption := fJPEGCompressor.JPEGOriginal.Width.ToString;
          lbImgOrigHeightVal.Caption := fJPEGCompressor.JPEGOriginal.Height.ToString;
          lbImgOrigSizeKBVal.Caption := SizeOfFileKB(AFilename).ToString;
          LoadImage(false, imgOriginal, miApplyBestFit.Checked);
        end;
      finally
        Screen.Cursor := crDefault;
      end;
    end;
  end;
end;

function TMainController.FormToObj(const AImageConfig: TImageConfig=nil): TImageConfig;
begin
  with OwnerView(fMainView) do begin
    if (fSelectedFilename <> '') or Assigned(AImageConfig) then begin
      if Assigned(AImageConfig) then
        result := AImageConfig
      else begin
        if not Assigned(fImageConfig) then begin
          fImageConfig := TImageConfig.Create;
          fImageConfigList.Add(fSelectedFilename, fImageConfig);
        end;
        result := fImageConfig;
      end;
      if Assigned(result) then begin
        with result do begin
          Compress := cbCompress.Checked;
          Quality := seQuality.Value;
          TargetKB := seTargetKBs.Value;
          AddToJSON := cbIncludeInJSONFile.Checked;
          Description := ebDescription.Text;
          Title := ebTitle.Text;
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
              ThumbnailSizePx := fThumbnailSizePx;
              PnlFilesWidth := pnlFiles.Width;
              PnlOriginalWidth := pnlOriginal.Width;
              ApplyToAll := cbApplyToAll.Checked;
              JsonFilename := ebFilename.Text;
              SourcePrefix := ebPrefix.Text;
              RunScript := fRunScript;
              CreateThumbnails := cbCreateThumbnails.Checked;
            end;
          end;
        end;
      end;
    end else
      result := nil;
  end;
end;

procedure TMainController.FullScreenClick(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    miFullscreen.Checked := not miFullscreen.Checked;
    miImgFullscreen.Checked := miFullscreen.Checked;
    miHideConfig.Checked := miFullscreen.Checked;
    miHideFiles.Checked := miFullscreen.Checked;
    miHideOriginal.Checked := miFullscreen.Checked;
    pnlFiles.Visible := not miFullscreen.Checked;
    pnlOriginal.Visible := not miFullscreen.Checked;
    spOriginal.Visible := not miFullscreen.Checked;
    pnlConfig.Visible := not miFullscreen.Checked;
    pnlConfigFlow.Visible := not miFullscreen.Checked;
  end;
  ResizeEvent(Sender);
end;

function TMainController.GetSelectedFilename: string;
var
  a: integer;
begin
  result := '';
  with OwnerView(fMainView) do begin
    for a := 0 to cblFiles.Count-1 do begin
      if cblFiles.Selected[a] then begin
        result := AddPath(cblFiles.Items[a]);
        Break;
      end;
    end;
    if (result = '') and
       (cblFiles.Count > 0) then
      result := AddPath(cblFiles.Items[0]);
  end;
  fImageChanged := result <> fSelectedFilename;
end;

procedure TMainController.ReplaceOriginals(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    miReplaceOriginals.Checked := not miReplaceOriginals.Checked;
    if (not FormData.RunScript) or
       ((not miReplaceOriginals.Checked) or
        (MessageDlg(cMsgReplaceOriginalsScriptWarning, mtWarning, mbOKCancel, 0) = mrOk)) then begin
      if not ValidSelection(Sender) then
        miReplaceOriginals.Checked := false;
    end else
      miReplaceOriginals.Checked := false;
    FormData.ReplaceOriginals := miReplaceOriginals.Checked;
  end;
end;

procedure TMainController.ApplyResponsiveLogic(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    //Labels display width/height in px in debug mode
    if lbClientWidth.Visible then
      lbClientWidth.Caption := ClientWidth.ToString;
    if lbClientHeight.Visible then
      lbClientHeight.Caption := ClientHeight.ToString;

    if ClientWidth <= cThirdFlowChangePx then
      pnlConfigFlow.Height := pnlGraphics.Height * 4
    else if (ClientWidth <= cSecondFlowChangePx) or 
            (ClientWidth <= cFirstFlowChangePx) then 
      pnlConfigFlow.Height := pnlGraphics.Height * 2
    else if ClientWidth >= cFirstFlowChangePx then
      pnlConfigFlow.Height := pnlGraphics.Height * 1;

    if ClientWidth > cDefaultClientWidth then
      pnlIncludeInFile.Width := fOrigPnlIncludeFileWidth + (ClientWidth - cDefaultClientWidth)
    else if (pnlIncludeInFile.Width <> pnlGraphics.Width) and
            (pnlIncludeInFile.Width <> fOrigPnlIncludeFileWidth) then
      pnlIncludeInFile.Width := fOrigPnlIncludeFileWidth;

    if (Sender = spOriginal) and
       (pnlOriginal.Width <= cMinOriginalWidth) then
      pnlOriginal.Width := cMinOriginalWidth
    else if (Sender = spFiles) and
            (pnlFiles.Width <= cMinFilesWidth) then
      pnlFiles.Width := cMinFilesWidth;
  end;
end;

procedure TMainController.Refresh(Sender: TObject);
var
  a: integer;
  function FileMatch: boolean;
  begin
    with OwnerView(fMainView) do begin
      if ExtractFilePath(cblFiles.Items[a]) = '' then
        result := cblFiles.Items[a] = ExtractFilename(fPersistFilename)
      else
        result := cblFiles.Items[a] = fPersistFilename;
    end;
  end;
begin
  if fSelectedFilename <> '' then begin
    Scan(Sender);
    if fPersistFilename <> '' then begin
      with OwnerView(fMainView) do begin
        for a := 0 to cblFiles.Count-1 do begin
          if FileMatch then begin
            cblFiles.Selected[a] := true;
            fSelectedFilename := fpersistFilename;
            break;
          end;
        end;
      end;
    end;
    LoadSelectedFromFile(false)
  end else
    Scan(Sender);
end;

procedure TMainController.ResizeEvent(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    ApplyResponsiveLogic(Sender);  
    CheckHideLabels;
    if (fSelectedFilename <> '') then begin
      Screen.Cursor := crHourGlass;
      try
        if not cbStretch.Checked then
          LoadImage(true, imgHome, miApplyBestFit.Checked);
        if not cbStretchOriginal.Checked then
          LoadImage(false, imgOriginal, miApplyBestFit.Checked);
      finally
        Screen.Cursor := crDefault;
      end;
    end;
  end;
end;

procedure TMainController.RestoreDefaults(Sender: TObject);
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
    with OwnerView(fMainView) do begin
      oldStartPath := ebStartPath.Text;
      oldDeepScan := miDeepScan.Checked;
      try
        LoadFormSettings(true);
      finally
        ResizeEvent(Sender);
        if (oldStartPath <> ebStartPath.Text) or
           (oldDeepScan <> miDeepScan.Checked) then
          Scan(Sender);
      end;
    end;
  end;
end;

procedure TMainController.RunDeploymentScript;
begin
  if FileExists(cShellScript) then begin
    with OwnerView(fMainView) do begin
      fDynamicScript.OutputPath := ebOutputDir.Text;
      fDynamicScript.SourcePrefix := ebPrefix.Text;
      fDynamicScript.OutputLines := mmScript.Lines;
      fDynamicScript.RunScript;
    end;
  end;
end;

function TMainController.ValidFormSelection: boolean;
begin
  with TStringList.Create do begin;
    try
      with OwnerView(fMainView) do begin
        if (rbTarget.Checked) and
           (seTargetKBs.Value = 0) then
          Add('Please enter a target file size in kilobytes');
      end;
    if Count > 0 then
      MessageDlg(Text, mtWarning, mbOKCancel, 0);
    finally
      result := Count = 0;
      Free
    end;
  end;
end;

function TMainController.ValidSelection(Sender: TObject): boolean;
var
  sl: TStringList;
  hasRotation, hasResampling, hasMultipleImages, hasReplaceOriginals, hasScript: boolean;
begin
  sl := TStringList.Create;
  try
    with OwnerView(fMainView) do begin
      if (Sender <> miReplaceOriginals) and
         (not FileIsSelected) then
        MessageDlg(cBatchProcessEvaluation, mtError, mbOKCancel, 0)
      else if EvaluationMode then begin
        HasPayWallConfig(hasRotation, hasResampling, hasMultipleImages, hasReplaceOriginals, hasScript);
        if hasReplaceOriginals then
          sl.Add(cReplaceOrigEval);
        if hasMultipleImages then
          sl.Add(cBatchProcessingEval);
        if hasRotation then
          sl.Add(cRotationEval);
        if hasResampling then
          sl.Add(cResamplingEval);
        if hasScript then
          sl.Add(cScriptEval);
        if sl.Count = 1 then
          sl.CommaText := sl.CommaText.Replace('• ', '');
        if sl.Count > 0 then begin
          sl.Add(' ');
          sl.Add(cLinkToBuyMessage);
        end;
      end;
      result := sl.Count = 0;
      if not result then begin
        if (EvaluationMode) and
           (MessageDlg(sl.Text, mtWarning, mbOKCancel, 0) = mrOk) then begin
          OpenURL(cGumRoadLink);
          miEnterLicenseClick(Sender);
        end;
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure TMainController.ViewsPopup(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    miHideOriginalPm.Checked := not pnlOriginal.Visible;
    miSplit.Enabled := pnlOriginal.Visible;
    miHideImageList.Checked := not pnlFiles.Visible;
    miImgFullscreen.Checked := miFullscreen.Checked;
  end;
end;

procedure TMainController.OpenSelectedExplorer(Sender: TObject);
begin
  if (fSelectedFilename = '') then
    MessageDlg(cMsgPleaseSelect, mtWarning, mbOKCancel, 0)
  else if not FileExists(fSelectedFilename) then
    MessageDlg(cMsgUnableToFind, mtWarning, mbOKCancel, 0)
  else
    ShellExecute(Application.Handle, 'open', 'explorer.exe', PChar('/select, "' +fSelectedFilename+'"'), nil, SW_NORMAL);
end;

procedure TMainController.OpenSelectedImage(Sender: TObject);
begin
  if (fSelectedFilename = '') then
    MessageDlg(cMsgPleaseSelect, mtWarning, mbOKCancel, 0)
  else if not FileExists(fSelectedFilename) then
    MessageDlg(cMsgUnableToFind, mtWarning, mbOKCancel, 0)
  else
    OpenURL(fSelectedFilename);
end;

procedure TMainController.OpenURL(const AURL: string);
var
  url: string;
begin
  url := StringReplace(AURL, '"', '%22', [rfReplaceAll]);
  ShellExecute(0, 'open', PChar(url), nil, nil, SW_SHOWNORMAL);
end;

procedure TMainController.OpenWith(Sender: TObject);
begin
  ShellExecute(OwnerView(fMainView).Handle, 'open', PChar('mspaint'), PChar(fSelectedFilename), nil, SW_SHOW);
end;

procedure TMainController.SaveFormSettings;
begin
  fMainModel.SaveFormSettings;
end;

procedure TMainController.Scan(Sender: TObject; const AClearItems: boolean=true);
var
  a: integer;
  filename,
  newFilename: string;
  imageLoaded: boolean;
  badFilenames: TStringList;
begin
  with OwnerView(fMainView) do begin
    if (not fDragAndDropping) and
       (Sender <> miClearFiles) then
      ScanDisk;
    fPersistFilename := fSelectedFilename;
    Screen.Cursor := crHourGlass;
    cblFiles.Items.BeginUpdate;
    badFilenames := TStringList.Create;
    try
      if (fWorkingDir <> ebStartPath.Text) or
         (Sender <> ebStartPath) then begin
        fWorkingDir := ebStartPath.Text;
        if AClearItems then begin
          cblFiles.Items.Clear;
          ClearConfigList;
        end;
        for filename in FilenameList do begin
          if (not filename.Contains('!')) and
             (LowerCase(filename).EndsWith('.jpg') or LowerCase(filename).EndsWith('.jpeg')) then begin
            if (fFilterSizeKB <= 0) or
               (SizeOfFileKB(filename) >= fFilterSizeKB) then begin
              if FormData.DeepScan or fDragAndDropping then
                newFilename := filename
              else
                newFilename := ExtractFileName(filename);
              if cblFiles.Items.IndexOf(newFilename) = -1 then begin
                cblFiles.Items.Insert(0, newFilename);
                cblFiles.Checked[0] := false;
              end;
            end;
          end else
            badFilenames.Add(filename);
        end;
        for a:=0 to badFilenames.Count-1 do
          FilenameList.Delete(FilenameList.IndexOf(badFilenames.Strings[a]));
        imageLoaded := LoadSelectedFromFile;
        cbApplyToAll.Checked := true;
        btnStart.Enabled := false;
        SetControlState(imageLoaded);
      end;
    finally
      if cblFiles.Items.Count = 0 then begin
        imgHome.Picture.Assign(nil);
        imgOriginal.Picture.Assign(nil);
        ClearImagePreviewLabels;
      end;
      if Trim(fMessages.Text) <> '' then
        mmMessages.Lines.Add(fMessages.Text);
      fMessages.Clear;
      badFilenames.Free;
      cblFiles.Items.EndUpdate;
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TMainController.ScanDisk;
var
  filenames: TStringDynArray;
  dlgProgress: TDlgProgress;
  filename: string;
begin
  dlgProgress := TDlgProgress.Create(fMainView);
  try
    with OwnerView(fMainView) do begin
      FilenameList.Clear;
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
            FilenameList.Add(filename);
        end;
        DirectoryScanned := true;
      except
        on e: exception do
          MessageDlg(e.Message, mtError, mbOKCancel, 0)
      end;
    end;
  finally
    dlgProgress.Free;
  end;
end;

procedure TMainController.SetChildControlES(const AParentControl: TControl; const AEnabled: Boolean);
var
  i: integer;
begin
  if Assigned(AParentControl) then begin
    if AParentControl is TWinControl then begin
      for i := 0 to TWinControl(AParentControl).ControlCount-1 do
        SetChildControlES(TWinControl(AParentControl).Controls[i], AEnabled);
    end;
  end;
  if (AParentControl is TLabel) then
    TLabel(AParentControl).Enabled := AEnabled
  else if (AParentControl is TWinControl) then
    AParentControl.Enabled := AEnabled;
end;

procedure TMainController.SetControlState(const AEnabled: boolean);
begin
  with OwnerView(fMainView) do begin
    SetChildControlES(pnlImage, AEnabled);
    SetChildControlES(pnlOriginal, AEnabled);
    lbFiles.Enabled := AEnabled;
    cbCompressPreview.Enabled := AEnabled;
    cbStretch.Enabled := AEnabled;
    cbStretchOriginal.Enabled := AEnabled;
    imgHome.Enabled := AEnabled;
  end;
end;

procedure TMainController.SetShrinkState(Sender: TObject);
begin
  with OwnerView(fMainView) do begin
    if not Loading then begin
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
      btnStart.Enabled := AllowStart;
    end;
  end;
end;

procedure TMainController.ShowDlgThumbnailSize(Sender: TObject);
begin
  with TDlgThumbnailSize.Create(fMainView) do begin
    try
      SizePx := fThumbnailSizePx;
      ShowModal;
      if RecordModified then
        fThumbnailSizePx := SizePx;
    finally
      Free;
    end;
  end;
end;

end.
