unit server.methods.pessoa;

interface

uses
  System.SysUtils,
  System.Classes,
  Datasnap.DSServer,
  Datasnap.DSAuth,
  System.TypInfo,
  System.Generics.Collections,
  REST.JSON,
  System.JSON,
  dao.pessoas,
  model.interfaces,
  model.entity.pessoa;

type
{$METHODINFO ON}
  TCadastro = class(TComponent)
  private
    FDaoPessoa: iDAO<TPessoa>;
  public
    { Public declarations }
    function pessoas: TJSONArray;
    function updatePessoas(Value: TJSONObject): TJSONObject;
    function acceptPessoas(Value: TJSONObject): TJSONObject;
    function cancelPessoas(Value: Int64): Boolean;
    function acceptPessoasLote(Value: TJSONArray): Boolean;
  end;

{$METHODINFO OFF}

implementation

uses
  System.StrUtils,
  model.enums,
  model.utils,
  model.conexao;

function TCadastro.acceptPessoas(Value: TJSONObject): TJSONObject;
var
  vPessoa: TPessoa;
  vPessoaResult: TPessoa;
begin
  vPessoa := TUtils.JSONToObject<TPessoa>(Value.ToString);
  FDaoPessoa := TDAOPessoa<TPessoa>.Create;
  try
    vPessoaResult := FDaoPessoa.Insert(vPessoa);
    Result := TUtils.ObjectToJSON<TPessoa>(vPessoaResult);
  finally
    vPessoa.Free;
  end;
end;

function TCadastro.cancelPessoas(Value: Int64): Boolean;
begin
  FDaoPessoa := TDAOPessoa<TPessoa>.Create;
  Result := FDaoPessoa.Delete(Value);
end;

function TCadastro.pessoas: TJSONArray;
var
  vListaPessoas: TObjectList<TPessoa>;
begin
  vListaPessoas := TObjectList<TPessoa>.Create;

  FDaoPessoa := TDAOPessoa<TPessoa>.Create;
  FDaoPessoa.Get(vListaPessoas);
  try
    Result := TUtils.ObjectListToJSON<TPessoa>(vListaPessoas);
  finally
    vListaPessoas.Free;
  end;
end;

function TCadastro.updatePessoas(Value: TJSONObject): TJSONObject;
var
  vPessoa: TPessoa;
  vPessoaResult: TPessoa;
begin
  FDaoPessoa := TDAOPessoa<TPessoa>.Create;
  vPessoa := TUtils.JSONToObject<TPessoa>(Value.ToString);
  try
    vPessoaResult := FDaoPessoa.Update(vPessoa);
    Result := TUtils.ObjectToJSON<TPessoa>(vPessoaResult);
  finally
    vPessoa.Free;
  end;
end;

function TCadastro.acceptPessoasLote(Value: TJSONArray): Boolean;
var
  vListaPessoas: TObjectList<TPessoa>;
begin
  FDaoPessoa := TDAOPessoa<TPessoa>.Create;
  vListaPessoas := TUtils.JsonToObjectList<TPessoa>(Value.ToString);
  try
    Result := FDaoPessoa.InsertLote(vListaPessoas);
  finally
    vListaPessoas.Free;
  end;
end;

end.
