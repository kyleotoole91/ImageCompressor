program TurboImageCompressor;

uses
  Vcl.Forms,
  uConstants in 'Source\uConstants.pas',
  uDlgFilter in 'Source\Views\uDlgFilter.pas' {DlgFilter},
  uDlgProgress in 'Source\Views\uDlgProgress.pas' {DlgProgress},
  uFrmMain in 'Source\Views\uFrmMain.pas' {FrmMain},
  uFrmShellScript in 'Source\Views\uFrmShellScript.pas' {FrmShellScript},
  uFrmSplash in 'Source\Views\uFrmSplash.pas' {frmSplash},
  uDynamicScript in 'Source\Utilis\uDynamicScript.pas',
  uFormData in 'Source\Serialized\uFormData.pas',
  uImageConfig in 'Source\Serialized\uImageConfig.pas',
  uMainController in 'Source\Controllers\uMainController.pas',
  uMainModel in 'Source\Models\uMainModel.pas',
  uJPEGCompressor in 'Source\Utilis\uJPEGCompressor.pas',
  uLicenseValidator in 'Source\Utilis\uLicenseValidator.pas';

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
