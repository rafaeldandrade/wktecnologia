unit view.cadastro;

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
  FMX.Objects,
  FMX.Layouts,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Edit,
  FMX.DateTimeCtrls,
  controller.pessoa,
  System.Rtti,
  System.Bindings.Outputs,
  FMX.Bind.Editors,
  Data.Bind.EngExt,
  FMX.Bind.DBEngExt,
  Data.Bind.Components, FMX.ListBox, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TfrmCadastro = class(TForm)
    lytGeral: TLayout;
    Layout1: TLayout;
    Label1: TLabel;
    Line2: TLine;
    edtId: TEdit;
    Layout2: TLayout;
    Label2: TLabel;
    Line3: TLine;
    edtNatureza: TEdit;
    Layout3: TLayout;
    Label3: TLabel;
    Line4: TLine;
    edtDocumento: TEdit;
    Layout4: TLayout;
    Label4: TLabel;
    Line5: TLine;
    edtPrimeiroNome: TEdit;
    Layout5: TLayout;
    Label5: TLabel;
    Line6: TLine;
    edtSobrenome: TEdit;
    Layout6: TLayout;
    Label6: TLabel;
    Line7: TLine;
    Layout7: TLayout;
    Label7: TLabel;
    Line8: TLine;
    edtCEP: TEdit;
    gpbEndereco: TGroupBox;
    lytEdit: TLayout;
    lblTitulo: TLabel;
    Line1: TLine;
    edtLogradouro: TEdit;
    Layout8: TLayout;
    Label8: TLabel;
    Line9: TLine;
    edtComplemento: TEdit;
    Layout9: TLayout;
    Label9: TLabel;
    Line10: TLine;
    edtBairro: TEdit;
    Layout10: TLayout;
    Label10: TLabel;
    Line11: TLine;
    edtCidade: TEdit;
    Layout11: TLayout;
    Label11: TLabel;
    Line12: TLine;
    edtUF: TEdit;
    edtDataRegistro: TDateEdit;
    gpbPessoa: TGroupBox;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    LinkControlToField7: TLinkControlToField;
    LinkControlToField8: TLinkControlToField;
    LinkControlToField9: TLinkControlToField;
    LinkControlToField10: TLinkControlToField;
    LinkControlToField11: TLinkControlToField;
    LinkControlToField12: TLinkControlToField;
    cbbNatureza: TComboBox;
    LinkListControlToField1: TLinkListControlToField;
    LinkPropertyToFieldItemIndex: TLinkPropertyToField;
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure cbbNaturezaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastro: TfrmCadastro;

implementation

{$R *.fmx}

procedure TfrmCadastro.Button1Click(Sender: TObject);
begin
  ControllerPessoa.Salvar;
end;

procedure TfrmCadastro.cbbNaturezaChange(Sender: TObject);
begin
  ControllerPessoa.AtualizarNatureza(cbbNatureza.ItemIndex);
end;

end.
