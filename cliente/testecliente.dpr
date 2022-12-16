program testecliente;

uses
  System.StartUpCopy,
  FMX.Forms,
  view.principal in 'src\view\view.principal.pas' {frmPrincipal},
  model.entity.pessoa in 'src\model\entity\model.entity.pessoa.pas',
  model.entity.endereco in 'src\model\entity\model.entity.endereco.pas',
  controller.pessoa in 'src\controller\controller.pessoa.pas' {ControllerPessoa: TDataModule},
  view.listagem in 'src\view\view.listagem.pas' {frmListagem},
  view.cadastro in 'src\view\view.cadastro.pas' {frmCadastro},
  model.enums in 'src\model\model.enums.pas',
  model.utils in 'src\model\utils\model.utils.pas',
  dao.pessoas in 'src\dao\dao.pessoas.pas' {daoPessoas: TDataModule},
  view.cadastrolote in 'src\view\view.cadastrolote.pas' {frmCadastroLote};

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TdaoPessoas, daoPessoas);
  Application.CreateForm(TControllerPessoa, ControllerPessoa);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
