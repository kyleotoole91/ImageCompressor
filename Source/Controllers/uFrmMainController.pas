unit uFrmMainController;

interface

uses
  System.Classes, SuperObject, uImageConfig, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Forms, Vcl.Dialogs, REST.JSON,
  Winapi.ShellAPI, WinApi.Windows, System.IOUtils, System.Types, uDlgProgress, uScriptVariables, System.Generics.Collections;

type
  TFrmMainController = class(TObject)
  strict private
    fOwner: TComponent;
    fScriptVariables: TScriptVariables;
    fImageConfigList: TDictionary<string, TImageConfig>;
  public
    constructor Create(const AOwner: TComponent);
    destructor Destroy; override;
    procedure RunDeploymentScript;
    function ValidSelection(Sender: TObject): boolean;
    function LoadSelectedFromFile(const ALoadForm: boolean=true): boolean;
    procedure ClearConfigList;
    function FileIsSelected: boolean;
    procedure ProcessFile(const AFilename: string);
    procedure CreateJSONFile(const AJSON: ISuperObject);
    procedure LoadImage(const AJPEG: TJPEGImage; const AImage: TImage);
    procedure LoadImageConfig(const AFilename: string);
    function SizeOfFileKB(const AFilename: string): uInt64;
    procedure HasPayWallConfig(out AHasTargetKB, AHasResampling, AHasMultipleImages, AHasReplaceOriginals: boolean);
    procedure OpenURL(const AURL: string);
    procedure ScanDisk;
    procedure SaveFormSettings;
    procedure LoadFormSettings(const ARestoreDefaults: boolean=false);
    procedure LoadImagePreview(const AFilename: string); overload;
    procedure AddToJSONFile(const AOriginalFileSize: Int64; const ACompressedFileSize: Int64);
    function FormToObj(const AImageConfig: TImageConfig=nil): TImageConfig;
    procedure ObjToForm(AImageConfig: TImageConfig=nil; const AOnlyFormData: boolean=false);
    property Owner: TComponent read fOwner write fOwner;
  end;

implementation

uses
  System.SysUtils, uFormData, System.UITypes, uConstants, uJPEGCompressor, uFrmMain;

{TFrmMainController}

constructor TFrmMainController.Create(const AOwner: TComponent);
begin
  inherited Create;
  if not (AOwner is TFrmMain) then
    raise Exception.Create('Unsupported class type')
  else
    fOwner := AOwner;
  fImageConfigList := TDictionary<string, TImageConfig>.Create;
  fScriptVariables := TScriptVariables.Create(AOwner);
end;

destructor TFrmMainController.Destroy;
begin
  if Assigned(fImageConfigList) then
    fImageConfigList.Free;
  if Assigned(fScriptVariables) then
    fScriptVariables.Free;
  inherited;
end;

procedure TFrmMainController.CreateJSONFile(const AJSON: ISuperObject);
var
  newfilename: string;
begin
  with TFrmMain(fOwner) do begin
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
end;

procedure TFrmMainController.ObjToForm(AImageConfig: TImageConfig=nil; const AOnlyFormData: boolean=false);
var
  imageConfig: TImageConfig;
begin
  with TFrmMain(fOwner) do begin
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
end;


function TFrmMainController.LoadSelectedFromFile(const ALoadForm: boolean=true): boolean;
begin
  try
    Screen.Cursor := crHourGlass;
    try
      with TFrmMain(fOwner) do begin
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
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  except
    on e: exception do begin
      MessageDlg(e.Classname+' '+e.message, mtError, [mbOK], 0);
      TFrmMain(fOwner).btnApply.Enabled := false;
      result := false;
    end;
  end;
end;

procedure TFrmMainController.ClearConfigList;
var
  key: string;
begin
  with TFrmMain(fOwner) do begin
    for key in fImageConfigList.Keys do
      fImageConfigList.Items[key].Free;
    fImageConfigList.Clear;
  end;
end;

function TFrmMainController.FileIsSelected: boolean;
var
  a: integer;
begin
  result := false;
  with TFrmMain(fOwner) do begin
    for a:=0 to cblFiles.Count-1 do begin
      result := cblFiles.Checked[a];
      if result then
        Break;
    end;
  end;
end;

procedure TFrmMainController.LoadImageConfig(const AFilename: string);
var
  key: string;
begin
  with TFrmMain(fOwner) do begin
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
end;

procedure TFrmMainController.ProcessFile(const AFilename: string);
begin
  with TFrmMain(TObject) do begin
    fStartTime := Now;
    try
      fFilename := AFilename;
      fSelectedFilename := fFilename;
      LoadImageConfig(fFilename);
      if cbApplyToAll.Checked then
        fFrmMainController.FormToObj;
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
end;

procedure TFrmMainController.LoadImage(const AJPEG: TJPEGImage; const AImage: TImage);
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
    with TFrmMain(fOwner) do begin
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
  end;
begin
  with TFrmMain(fOwner) do begin
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
end;

procedure TFrmMainController.HasPayWallConfig(out AHasTargetKB, AHasResampling, AHasMultipleImages, AHasReplaceOriginals: boolean);
var
  key: string;
  imgConfig: TImageConfig;
begin
  with TFrmMain(fOwner) do begin
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
end;

function TFrmMainController.SizeOfFileKB(const AFilename: string): uInt64;
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

procedure TFrmMainController.AddToJSONFile(const AOriginalFileSize: Int64; const ACompressedFileSize: Int64);
var
  sourcePrefix: string;
begin
  with TFrmMain(fOwner) do begin
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
end;

procedure TFrmMainController.LoadImagePreview(const AFilename: string);
begin
  with TFrmMain(fOwner) do begin
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
end;

function TFrmMainController.FormToObj(const AImageConfig: TImageConfig=nil): TImageConfig;
begin
  with TFrmMain(fOwner) do begin
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
end;

procedure TFrmMainController.SaveFormSettings;
var
  jsonStr: string;
  json: ISuperObject;
begin
  try
    with TFrmMain(fOwner) do begin
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
    end;
  finally
    json := nil;
  end;
end;

procedure TFrmMainController.RunDeploymentScript;
begin
  if FileExists(cShellScript) then begin
    with TFrmMain(fOwner) do begin
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
end;

function TFrmMainController.ValidSelection(Sender: TObject): boolean;
var
  sl: TStringList;
  hasTargetKB, hasResampling, hasMultipleImages, hasReplaceOriginals: boolean;
begin
  sl := TStringList.Create;
  try
    with TFrmMain(fOwner) do begin
      if (Sender <> miReplaceOriginals) and
         (not fFrmMainController.FileIsSelected) then
        MessageDlg(cBatchProcessEvaluation, mtError, mbOKCancel, 0)
      else if fEvaluationMode then begin
        fFrmMainController.HasPayWallConfig(hasTargetKB, hasResampling, hasMultipleImages, hasReplaceOriginals);
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
          fFrmMainController.OpenURL(cGumRoadLink);
          miEnterLicenseClick(nil);
        end;
      end;
    end;
  finally
    sl.Free;
  end;
end;


procedure TFrmMainController.LoadFormSettings(const ARestoreDefaults: boolean=false);
var
  sl: TStringList;
  json: ISuperObject;
begin
  sl := TStringList.Create;
  try
    with TFrmMain(fOwner) do begin
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
    end;
  finally
    sl.Free;
    json := nil;
  end;
end;

procedure TFrmMainController.OpenURL(const AURL: string);
var
  url: string;
begin
  url := StringReplace(AURL, '"', '%22', [rfReplaceAll]);
  ShellExecute(0, 'open', PChar(url), nil, nil, SW_SHOWNORMAL);
end;


procedure TFrmMainController.ScanDisk;
var
  filenames: TStringDynArray;
  dlgProgress: TDlgProgress;
  filename: string;
begin
  dlgProgress := TDlgProgress.Create(fOwner);
  try
    with TFrmMain(fOwner) do begin
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
    end;
  finally
    dlgProgress.Free;
  end;
end;

end.
