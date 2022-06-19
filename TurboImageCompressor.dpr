program TurboImageCompressor;

uses
  Vcl.Forms,
  uFrmMain in 'Source\uFrmMain.pas' {FrmMain},
  uImageConfig in 'Source\uImageConfig.pas',
  uJPEGCompressor in 'Source\uJPEGCompressor.pas',
  uFrmSplash in 'Source\uFrmSplash.pas' {frmSplash},
  uLicenseValidator in 'Source\uLicenseValidator.pas',
  uSecrets in 'Source\uSecrets.pas',
  uConstants in 'Source\uConstants.pas',
  uDlgFilter in 'Source\uDlgFilter.pas' {DlgFilter};

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
