unit uMainModel;

interface

uses
  System.Classes, SuperObject, uImageConfig, Vcl.ExtCtrls, Vcl.Forms, Vcl.Dialogs, REST.JSON;

type
  TMainModel = class(TObject)
  strict private
    fOwner: TObject;
  public
    constructor Create(const AOwner: TObject);
    procedure LoadFormSettings(const ARestoreDefaults: boolean=false);
    procedure SaveFormSettings;
  end;

implementation

uses
  System.SysUtils, uFormData, uConstants, uJPEGCompressor, uMainController, uFrmMain;

procedure TMainModel.SaveFormSettings;
var
  jsonStr: string;
  json: ISuperObject;
begin
  try
    with TMainController(fOwner) do begin
      with TFrmMain(Owner) do begin
        FormToObj(FormData);
        jsonStr := TJson.ObjectToJsonString(FormData);
        json := SO(jsonStr);
        json.S['sourceDir'] := ebStartPath.Text;
        json.S[cOutputDir] := ebOutputDir.Text;
        json.I['filterSizeKB'] := fFilterSizeKB;
        json.B['replaceOriginals'] := FormData.ReplaceOriginals;
        json.B['deepScan'] := FormData.DeepScan;
        json.I['pnlFilesWidth'] := pnlFiles.Width;
        json.I['pnlScriptHeight'] := pnlScript.Height;
        json.I['pnlOriginalWidth'] := pnlOriginal.Width;
        json.B['applyToAll'] := cbApplyToAll.Checked;
        json.S['jsonFilename'] := ebFilename.Text;
        json.S['prefix'] := ebPrefix.Text;
        json.B['runScript'] := fRunScript;
        json.B['autoPrefix'] := FormData.AutoPrefix;
        json.SaveTo(cSettingsFilename);
      end;
    end;
  finally
    json := nil;
  end;
end;

constructor TMainModel.Create(const AOwner: TObject);
begin
  inherited Create;
  if not (AOwner is TMainController) then
    raise Exception.Create('Unsupported class type')
  else
    fOwner := AOwner;
end;

procedure TMainModel.LoadFormSettings(const ARestoreDefaults: boolean=false);
var
  sl: TStringList;
  json: ISuperObject;
begin
  sl := TStringList.Create;
  try
    with TMainController(fOwner) do begin
      with TFrmMain(Owner) do begin
        if Assigned(FormData) then begin
          FormData.Free;
          FormData := nil;
        end;
        if (not ARestoreDefaults) and
           (FileExists(cSettingsFilename)) then begin
          sl.LoadFromFile(cSettingsFilename);
          FormData := TJson.JsonToObject<TFormData>(sl.Text);
          try
            if Assigned(FormData) then begin
              ObjToForm(FormData);
              json := SO(sl.Text);
              if json.S['sourceDir'] <> '' then
                ebStartPath.Text := json.S['sourceDir'];
              if ebOutputDir.Text <> '' then
                ebOutputDir.Text := json.S[cOutputDir];
              fFilterSizeKB := json.I['filterSizeKB'];
              FormData.ReplaceOriginals := json.B['replaceOriginals'];
              FormData.DeepScan := json.B['deepScan'];
              cbApplyToAll.Checked := json.B['applyToAll'];
              ebFilename.Text := json.S['jsonFilename'];
              FormData.RunScript := json.B['runScript'];
              ebPrefix.Text := json.S['prefix'];
              FormData.AutoPrefix := json.B['autoPrefix'];
              if sl.Text.Contains('pnlOriginalWidth') then
                pnlOriginal.Width := json.I['pnlOriginalWidth']
              else
                pnlOriginal.Width := cDefaultOriginalWidth;
              if sl.Text.Contains('pnlScript') then
                pnlScript.Height := json.I['pnlScriptHeight']
              else
                pnlScript.Height := cDefaultPnlScriptHeight;
              if sl.Text.Contains('pnlFiles') then
                pnlFiles.Width := json.I['pnlFilesWidth']
              else
                pnlFiles.Width := cDefaultPnlFilesWidth;
            end;
          finally
            fSelectedFilename := '';
          end;
        end;
        if not Assigned(FormData) then begin
          FormData := TFormData.Create;
          if ARestoreDefaults then begin
            with TImageConfig.Create do begin
              try
                FormData.Quality := Quality;
                FormData.FilterSizeKB := 0;
                FormData.Compress := Compress;
                FormData.TargetKB := TargetKB;
                FormData.ResampleMode := ResampleMode;
                FormData.RotateAmount := RotateAmount;
                FormData.ApplyGraphics := ApplyGraphics;
                FormData.Description := Description;
                FormData.Description := Description;
                FormData.ShrinkByWidth := ShrinkByWidth;
                FormData.ShrinkByValue := ShrinkByValue;
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
          ObjToForm(FormData)
        end
      end;
    end;
  finally
    sl.Free;
    json := nil;
  end;
end;

end.
