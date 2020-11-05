program XE8SnapDSSMProj;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  main in 'main.pas' {fMain},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerMethods1: TDSServerModule},
  ServerContainerUnit1 in 'ServerContainerUnit1.pas' {ServerContainer1: TDataModule},
  uStats in 'uStats.pas',
  MemoWin in 'MemoWin.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
end.

