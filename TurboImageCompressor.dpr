program TurboImageCompressor;

uses
  Vcl.Forms,
  uFrmMain in 'Source\uFrmMain.pas' {FrmMain},
  uImageConfig in 'Source\uImageConfig.pas',
  uJPEGCompressor in 'Source\uJPEGCompressor.pas',
  uFrmSplash in 'Source\uFrmSplash.pas' {frmSplash},
  uLicenseValidator in 'Source\uLicenseValidator.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmSplash, frmSplash);
  frmSplash.ShowModal;
  Application.Run;
end.
