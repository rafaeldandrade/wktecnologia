program servidor;
{$APPTYPE GUI}

uses
  System.StartUpCopy,
  FMX.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  view.principal in 'src\view\view.principal.pas' {Form1},
  server.methods.pessoa in 'src\server\server.methods.pessoa.pas',
  server.container in 'src\server\server.container.pas' {ServerContainer1: TDataModule},
  server.webmodule in 'src\server\server.webmodule.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.