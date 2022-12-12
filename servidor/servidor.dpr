program servidor;
{$APPTYPE GUI}

uses
  System.StartUpCopy,
  FMX.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  view.principal in 'src\view\view.principal.pas' {frmPrincipal},
  server.methods.pessoa in 'src\server\server.methods.pessoa.pas',
  server.container in 'src\server\server.container.pas' {ServerContainer1: TDataModule},
  server.webmodule in 'src\server\server.webmodule.pas' {WebModule1: TWebModule},
  model.utils in '..\cliente\src\model\utils\model.utils.pas',
  model.enums in '..\cliente\src\model\model.enums.pas',
  model.entity.endereco in '..\cliente\src\model\entity\model.entity.endereco.pas',
  model.entity.pessoa in '..\cliente\src\model\entity\model.entity.pessoa.pas',
  model.cep in 'src\model\model.cep.pas',
  controller.viacep in 'src\controller\controller.viacep.pas' {controllerViacep: TDataModule},
  model.interfaces in 'src\model\model.interfaces.pas',
  model.conexao in 'src\model\model.conexao.pas',
  dao.pessoas in 'src\dao\dao.pessoas.pas',
  dao.enderecos in 'src\dao\dao.enderecos.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TcontrollerViacep, controllerViacep);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
