unit view.principal;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Layouts,
  FMX.Effects,
  FMX.MultiView,
  FMX.TabControl,
  System.Generics.Collections,
  System.Actions,
  FMX.ActnList;

type
  TfrmPrincipal = class(TForm)
    lytTitulo: TLayout;
    recTitulo: TRectangle;
    lblTitulo: TLabel;
    mtvMenu: TMultiView;
    lytConteudo: TLayout;
    recMenu: TRectangle;
    ShadowEffect1: TShadowEffect;
    lytMenuTopo: TLayout;
    btnMenu: TButton;
    Rectangle1: TRectangle;
    Layout1: TLayout;
    lblMenuTitulo: TLabel;
    btnSair: TButton;
    RoundRect1: TRoundRect;
    ShadowEffect2: TShadowEffect;
    Label1: TLabel;
    RoundRect2: TRoundRect;
    Image1: TImage;
    tbConteudo: TTabControl;
    tbiLista: TTabItem;
    tbiCadastro: TTabItem;
    ActionList1: TActionList;
    actLista: TChangeTabAction;
    actCadastro: TChangeTabAction;
    btnNovo: TButton;
    RoundRect5: TRoundRect;
    ShadowEffect5: TShadowEffect;
    Label3: TLabel;
    RoundRect6: TRoundRect;
    Image3: TImage;
    btnAlterar: TButton;
    RoundRect7: TRoundRect;
    ShadowEffect6: TShadowEffect;
    Label4: TLabel;
    RoundRect8: TRoundRect;
    Image4: TImage;
    btnSalvar: TButton;
    RoundRect13: TRoundRect;
    ShadowEffect9: TShadowEffect;
    Label7: TLabel;
    RoundRect14: TRoundRect;
    Image7: TImage;
    btnCancelar: TButton;
    recFiltrarCor: TRoundRect;
    ShadowEffect4: TShadowEffect;
    lblFiltarTitulo: TLabel;
    recFiltarImagem: TRoundRect;
    imgFiltarImagem: TImage;
    btnExcluir: TButton;
    RoundRect3: TRoundRect;
    ShadowEffect3: TShadowEffect;
    Label2: TLabel;
    RoundRect4: TRoundRect;
    Image2: TImage;
    Layout2: TLayout;
    btnAtualizar: TButton;
    RoundRect9: TRoundRect;
    ShadowEffect7: TShadowEffect;
    Label5: TLabel;
    RoundRect10: TRoundRect;
    Image5: TImage;
    Layout3: TLayout;
    Layout4: TLayout;
    actSair: TAction;
    tbiCadastroLote: TTabItem;
    btnCadastrarLote: TButton;
    RoundRect11: TRoundRect;
    ShadowEffect8: TShadowEffect;
    Label6: TLabel;
    RoundRect12: TRoundRect;
    Image6: TImage;
    actCadastroLote: TChangeTabAction;
    procedure FormCreate(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
  private
    procedure InicializaFormularios;
    procedure CarregarAbaListagem;
    procedure CarregarAbaCadastro;
    procedure CarregarAbaCadastroLote;
    { Private declarations }
  public
    procedure Sair;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses
  view.listagem,
  view.cadastro, controller.pessoa, view.cadastrolote;

procedure TfrmPrincipal.actSairExecute(Sender: TObject);
begin
  Sair;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  InicializaFormularios;
end;

procedure TfrmPrincipal.InicializaFormularios;
begin
  CarregarAbaListagem;
  CarregarAbaCadastro;
  CarregarAbaCadastroLote;
end;

procedure TfrmPrincipal.Sair;
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.CarregarAbaCadastroLote;
begin
  if not Assigned(frmCadastroLote) then
  begin
    frmCadastroLote := TfrmCadastroLote.Create(Self);
  end;
  tbiCadastroLote.AddObject(frmCadastroLote.lytGeral);
end;

procedure TfrmPrincipal.CarregarAbaCadastro;
begin
  if not Assigned(frmCadastro) then
  begin
    frmCadastro := TfrmCadastro.Create(Self);
  end;
  tbiCadastro.AddObject(frmCadastro.lytGeral);
end;

procedure TfrmPrincipal.CarregarAbaListagem;
begin
  if not Assigned(frmListagem) then
  begin
    frmListagem := TfrmListagem.Create(Self);
  end;
  tbiLista.AddObject(frmListagem.lytGeral);
end;

end.
