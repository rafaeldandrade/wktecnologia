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
  System.JSON;

type
{$METHODINFO ON}
  TCadastro = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function Pessoas: TJSONArray;
    function updatePessoas(Value: TJSONObject): TJSONObject;
    function acceptPessoas(Value: TJSONObject): TJSONObject;
    function deletePessoas(Value: Integer): Boolean;
  end;

{$METHODINFO OFF}

implementation

uses
  System.StrUtils,
  model.enums,
  model.utils,
  model.entity.pessoa,
  server.conexao;

function TCadastro.acceptPessoas(Value: TJSONObject): TJSONObject;
var
  vPessoa: TPessoa;
  vPessoaResult: TPessoa;
begin
  dmConexao := TdmConexao.Create(nil);
  try
    vPessoa := TUtils.JSONToObject<TPessoa>(Value.ToString);
    vPessoaResult := dmConexao.InsertPessoa(vPessoa);
    Result := TUtils.ObjectToJSON<TPessoa>(vPessoaResult);
  finally
    vPessoa.Free;
    dmConexao.Free;
  end;

end;

function TCadastro.deletePessoas(Value: Integer): Boolean;
begin
  dmConexao := TdmConexao.Create(nil);
  try
    Result := dmConexao.DeletePessoa(Value);
  finally
    dmConexao.Free;
  end;
end;

function TCadastro.Pessoas: TJSONArray;
var
  vListaPessoas: TObjectList<TPessoa>;
begin
  dmConexao := TdmConexao.Create(nil);
  try
    vListaPessoas := dmConexao.GetPessoas;
    Result := TUtils.ObjectListToJSON<TPessoa>(vListaPessoas);
  finally
    dmConexao.Free;
    vListaPessoas.Free;
  end;
end;

function TCadastro.updatePessoas(Value: TJSONObject): TJSONObject;
var
  vPessoa: TPessoa;
  vPessoaResult: TPessoa;
begin
  dmConexao := TdmConexao.Create(nil);
  try
    vPessoa := TUtils.JSONToObject<TPessoa>(Value.ToString);
    vPessoaResult := dmConexao.UpdatePessoa(vPessoa);
    Result := TUtils.ObjectToJSON<TPessoa>(vPessoaResult);
  finally
    vPessoa.Free;
    dmConexao.Free;
  end;
end;

end.
