program JPGFileCompress;

uses
  Vcl.Forms,
  uFrmJPGFileCompress in 'Source\uFrmJPGFileCompress.pas' {FrmMain},
  uImageConfig in 'Source\uImageConfig.pas',
  uJPEGCompressor in 'Source\uJPEGCompressor.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
