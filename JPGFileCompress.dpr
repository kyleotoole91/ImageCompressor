program JPGFileCompress;

uses
  Vcl.Forms,
  uFrmJPGFileCompress in 'uFrmJPGFileCompress.pas' {cbShrink},
  uJPEGCompressor in 'uJPEGCompressor.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
