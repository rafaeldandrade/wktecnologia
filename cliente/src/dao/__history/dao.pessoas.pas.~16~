unit dao.pessoas;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  REST.Types,
  REST.Client,
  REST.JSON,
  System.JSON,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  model.entity.endereco,
  model.entity.pessoa,
  model.enums,
  model.utils;

type
  TdaoPessoas = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
  private
    { Private declarations }
  public
    procedure Nova(aPessoa: TPessoa);
    procedure Atualizar(aPessoa: TPessoa);
    procedure Excluir(aPessoa: TPessoa);
    procedure Carregar(var aLista: TObjectList<TPessoa>);
  end;

var
  daoPessoas: TdaoPessoas;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

{ TdaoPessoas }

procedure TdaoPessoas.Atualizar(aPessoa: TPessoa);
var
  vObjeto: TJSONObject;
begin
  vObjeto := TUtils.ObjectToJSON<TPessoa>(aPessoa);
  try
    RESTRequest1.Method := rmPOST;
    RESTRequest1.Params.ParameterByName('body').Kind := pkREQUESTBODY;
    RESTRequest1.Params.ParameterByName('body').Value := vObjeto.ToString;
    RESTRequest1.Execute;
  finally
    vObjeto.Free;
  end;
end;

procedure TdaoPessoas.Carregar(var aLista: TObjectList<TPessoa>);
var
  vListaObjetos: TObjectList<TPessoa>;
begin
  RESTRequest1.Method := rmGET;
  RESTRequest1.Execute;

  vListaObjetos := TUtils.JsonToObjectList<TPessoa>(RESTResponse1.Content);
  try
    aLista.Clear;

    aLista.AddRange(vListaObjetos.ToArray);
    vListaObjetos := Nil;
  finally
    vListaObjetos.Free;
  end;
end;

procedure TdaoPessoas.Excluir(aPessoa: TPessoa);
begin
  RESTRequest1.Method := rmDELETE;
  RESTRequest1.Resource := aPessoa.IdPessoa.ToString;
  RESTRequest1.Execute;
  RESTRequest1.Resource := '';
end;

procedure TdaoPessoas.Nova(aPessoa: TPessoa);
var
  vObjeto: TJSONObject;
begin
  vObjeto := TUtils.ObjectToJSON<TPessoa>(aPessoa);
  try
    RESTRequest1.Method := rmPUT;
    RESTRequest1.Params.ParameterByName('body').Kind := pkREQUESTBODY;
    RESTRequest1.Params.ParameterByName('body').Value := vObjeto.ToString;
    RESTRequest1.Execute;
  finally
    vObjeto.Free;
  end;
end;

end.
