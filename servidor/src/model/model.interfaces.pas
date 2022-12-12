unit model.interfaces;

interface

uses
  FireDAC.Comp.Client,
  System.Generics.Collections;

type
  iConexao = interface
    function Conexao: TFDConnection;
  end;

  iDAO<T: class> = interface
    function Get(var aLista: TObjectList<T>): iDAO<T>;
    function Update(Value: T): T;
    function Insert(Value: T): T;
    function Delete(Value: Int64): Boolean;
    function InsertLote(Value: TObjectList<T>): Boolean;
  end;

implementation

end.
