program TurboImageCompressor;

uses
  Vcl.Forms,
  uJPEGCompressor in 'Source\uJPEGCompressor.pas',
  uLicenseValidator in 'Source\uLicenseValidator.pas',
  uConstants in 'Source\uConstants.pas',
  uDlgDefaults in 'Source\Views\uDlgDefaults.pas' {FrmDefaultConfig},
  uDlgFilter in 'Source\Views\uDlgFilter.pas' {DlgFilter},
  uDlgProgress in 'Source\Views\uDlgProgress.pas' {DlgProgress},
  uFrmMain in 'Source\Views\uFrmMain.pas' {FrmMain},
  uFrmShellScript in 'Source\Views\uFrmShellScript.pas' {FrmShellScript},
  uFrmSplash in 'Source\Views\uFrmSplash.pas' {frmSplash},
  uScriptVariables in 'Source\Utilis\uScriptVariables.pas',
  uFormData in 'Source\Serialized\uFormData.pas',
  uImageConfig in 'Source\Serialized\uImageConfig.pas',
  uFrmMainController in 'Source\Controllers\uFrmMainController.pas';

{$R *.res}

  function ValidateStartup: boolean;
  begin
    with TfrmSplash.Create(nil) do begin
      try
        ShowModal;
        FrmMain.EvaluationMode := not HasValidLicense;
      finally
        result := StartApp;
        Free;
      end;
    end;
  end;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  if ValidateStartup then
    Application.Run;
end.
