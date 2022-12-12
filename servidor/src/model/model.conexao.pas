unit model.conexao;

interface

uses
  model.interfaces,
  FireDAC.Comp.Client;

type
  TConexao = class(TInterfacedObject, iConexao)
  private
    FConexao: TFDConnection;
  public
    constructor Create(aServidor: String);
    destructor Destroy; override;
    class function New(aServidor: String): iConexao;
    function Conexao: TFDConnection;
  end;

implementation

{ TConexao }

function TConexao.Conexao: TFDConnection;
begin
  Result := FConexao;
end;

constructor TConexao.Create(aServidor: String);
begin
  if not Assigned(FConexao) then
  begin
    FConexao := TFDConnection.Create(nil);
  end;
  FConexao.ConnectionDefName := aServidor;
end;

destructor TConexao.Destroy;
begin
  FConexao.Close;
  FConexao.Free;
  inherited;
end;

class function TConexao.New(aServidor: String): iConexao;
begin
  Result := Self.Create(aServidor);
end;

end.
