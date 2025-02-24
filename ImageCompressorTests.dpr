program ImageCompressorTests;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  TestImageCompressorCLI in 'Tests\TestImageCompressorCLI.pas',
  uJPEGCompressor in 'Source\Utilis\uJPEGCompressor.pas',
  uConstants in 'Source\uConstants.pas',
  uImageConfig in 'Source\Serialized\uImageConfig.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.