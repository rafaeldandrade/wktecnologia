unit dao.pessoas;

interface

uses
  model.interfaces,
  System.Generics.Collections,
  model.entity.pessoa,
  model.utils,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.Stan.Param,
  model.conexao,
  model.enums;

type
  TDAOPessoa<T: TPessoa> = class(TInterfacedObject, iDAO<T>)
  private
  public
    function Get(var aLista: TObjectList<T>): iDAO<T>;
    function Update(Value: T): T;
    function Insert(Value: T): T;
    function Delete(Value: Int64): Boolean;
    function InsertLote(Value: TObjectList<T>): Boolean;
  end;

implementation

uses
  Data.DB,
  dao.enderecos,
  System.Classes;

{ TDAOPessoa<T> }

function TDAOPessoa<T>.Delete(Value: Int64): Boolean;
const
  vDeletePessoa = 'DELETE FROM public.pessoa WHERE idpessoa=:idpessoa; ';
var
  vConexao: iConexao;
begin
  Result := False;
  vConexao := TConexao.New('PRINCIPAL');
  vConexao.conexao.StartTransaction;
  try
    vConexao.conexao.ExecSQL(vDeletePessoa, [Value],
      [ftLargeint]);

    vConexao.conexao.Commit;
    Result := True;
  except
    vConexao.conexao.Rollback;
  end;

end;

function TDAOPessoa<T>.Get(var aLista: TObjectList<T>): iDAO<T>;
var
  vQry: TFDQuery;
  vPessoa: TPessoa;
begin
  Result := Self;

  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := TConexao.New('PRINCIPAL').conexao;
    vQry.SQL.Clear;
    vQry.SQL.Add
      ('SELECT p.idpessoa, p.flnatureza, p.dsdocumento, p.nmprimeiro, p.nmsegundo, p.dtregistro, ');
    vQry.SQL.Add
      ('e.idendereco, e.dscep, i.dsuf, i.nmcidade, i.nmbairro, i.nmlogradouro, i.dscomplemento ');
    vQry.SQL.Add('FROM PESSOA P  ');
    vQry.SQL.Add('join endereco e on e.idpessoa = p.idpessoa  ');
    vQry.SQL.Add
      ('LEFT join endereco_integracao i on i.idendereco = e.idendereco  ');
    vQry.Open;

    while not vQry.Eof do
    begin
      vPessoa := TPessoa.New;

      vPessoa.IdPessoa := vQry.FieldByName('idpessoa').AsLargeInt;
      vPessoa.FlNatureza := TNaturezaPessoa(vQry.FieldByName('flnatureza')
          .AsInteger);
      vPessoa.DsDocumento := vQry.FieldByName('dsdocumento').AsString;
      vPessoa.NmPrimeiro := vQry.FieldByName('nmprimeiro').AsString;
      vPessoa.NmSegundo := vQry.FieldByName('nmsegundo').AsString;
      vPessoa.DtRegistro := vQry.FieldByName('dtregistro').AsDateTime;
      vPessoa.endereco.IdEndereco := vQry.FieldByName('idendereco').AsLargeInt;
      vPessoa.endereco.DsCep := vQry.FieldByName('dscep').AsString;
      vPessoa.endereco.DsUF := vQry.FieldByName('dsuf').AsString;
      vPessoa.endereco.NmCidade := vQry.FieldByName('nmcidade').AsString;
      vPessoa.endereco.NmBairro := vQry.FieldByName('nmbairro').AsString;
      vPessoa.endereco.NmLogradouro := vQry.FieldByName('nmlogradouro')
        .AsString;
      vPessoa.endereco.DsComplemento :=
        vQry.FieldByName('dscomplemento').AsString;

      aLista.Add(vPessoa);

      vQry.Next;
    end;

  finally
    vQry.Free;
  end;

end;

function TDAOPessoa<T>.Insert(Value: T): T;
const
  vInsertPessoa = 'WITH pess AS ( ' + '  INSERT INTO public.pessoa ' +
    '  (flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro) ' +
    '  VALUES(:flnatureza, :dsdocumento, :nmprimeiro, :nmsegundo, :dtregistro) RETURNING idpessoa '
    + '), ' + 'ende AS ( ' + '  INSERT INTO public.endereco ' +
    '  (idpessoa, dscep) ' +
    '  VALUES((SELECT idpessoa FROM pess), :dscep) RETURNING idendereco ' +
    '), ' + 'endeint AS ( ' + '  INSERT INTO public.endereco_integracao ' +
    '  (idendereco) ' + '  VALUES((SELECT idendereco FROM ende)) ' + ') ' +
    'SELECT pess.idpessoa FROM pess ';
var
  vIdPessoa: Int64;
  vConexao: iConexao;
begin
  vConexao := TConexao.New('PRINCIPAL');
  vConexao.conexao.StartTransaction;
  try
    vIdPessoa := vConexao.conexao.ExecSQLScalar(vInsertPessoa,
      [Value.FlNatureza, Value.DsDocumento, Value.NmPrimeiro, Value.NmSegundo,
        Value.DtRegistro, Value.endereco.DsCep],
      [ftSmallint, ftString, ftString, ftString, ftDate, ftString]);
    vConexao.conexao.Commit;
    Value.IdPessoa := vIdPessoa;
  except
    vConexao.conexao.Rollback;
  end;

  TThread.CreateAnonymousThread(
      procedure
    begin
      TEnderecosDAO.AtualizarVazios;
    end).Start;

  Result := Value;
end;

function TDAOPessoa<T>.InsertLote(Value: TObjectList<T>): Boolean;
const
  vInsertPessoa = 'INSERT INTO public.pessoa ' +
    ' (flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro) ' +
    ' VALUES(:flnatureza, :dsdocumento, :nmprimeiro, :nmsegundo, :dtregistro) RETURNING idpessoa {INTO :idpessoa} ';
  vInsertEndereco = ' INSERT INTO public.endereco (idpessoa, dscep) ' +
    ' VALUES(:idpessoa, :dscep) RETURNING idendereco {INTO :idendereco} ';
  vInsertEnderecoIntegracao = '  INSERT INTO public.endereco_integracao (idendereco) '+
    ' VALUES(:idendereco) ';
var
  vQryPessoa: TFDQuery;
  vQry2Endereco: TFDQuery;
  vQry3EnderecoInt: TFDQuery;
  vPessoa: TPessoa;
  I: Integer;
  vConexao: iConexao;
begin
  Result := False;

  vQryPessoa := TFDQuery.Create(nil);
  vQry2Endereco := TFDQuery.Create(nil);
  vQry3EnderecoInt := TFDQuery.Create(nil);
  try
    vConexao := TConexao.New('PRINCIPAL');
    vQryPessoa.Connection := vConexao.conexao;
    vQryPessoa.SQL.Clear;
    vQryPessoa.SQL.Text := vInsertPessoa;

    vQryPessoa.Params[0].DataType := ftSmallint;

    vQryPessoa.Params[1].DataType := ftString;
    vQryPessoa.Params[1].Size := 20;

    vQryPessoa.Params[2].DataType := ftString;
    vQryPessoa.Params[2].Size := 100;

    vQryPessoa.Params[3].DataType := ftString;
    vQryPessoa.Params[3].Size := 100;

    vQryPessoa.Params[4].DataType := ftDate;

    vQryPessoa.Params[5].DataType := ftLargeint;
    vQryPessoa.Params[5].ParamType := ptInputOutput;

    vQryPessoa.Params.ArraySize := Value.Count;

    for I := 0 to Value.Count - 1 do
    begin
      vQryPessoa.Params[0].AsSmallInts[I] := Ord(Value[I].FlNatureza);
      vQryPessoa.Params[1].AsStrings[I] := Value[I].DsDocumento;
      vQryPessoa.Params[2].AsStrings[I] := Value[I].NmPrimeiro;
      vQryPessoa.Params[3].AsStrings[I] := Value[I].NmSegundo;
      vQryPessoa.Params[4].AsDates[I] := Value[I].DtRegistro;
    end;

    vConexao.conexao.StartTransaction;
    try
      vQryPessoa.Execute(Value.Count, 0);
      vConexao.conexao.Commit;
      Result := True;
    except
      vConexao.conexao.Rollback;
    end;

    if Result then
    begin
      vQry2Endereco.Connection := vConexao.conexao;
      vQry2Endereco.SQL.Clear;
      vQry2Endereco.SQL.Text := vInsertEndereco;

      vQry2Endereco.Params[0].DataType := ftLargeint;
      vQry2Endereco.Params[1].DataType := ftString;
      vQry2Endereco.Params[1].Size := 15;
      vQry2Endereco.Params[2].DataType := ftLargeint;
      vQry2Endereco.Params[2].ParamType := ptInputOutput;
      vQry2Endereco.Params.ArraySize := Value.Count;

      for I := 0 to Value.Count - 1 do
      begin
        vQry2Endereco.Params[0].AsLargeInts[I] := vQryPessoa.Params[5].AsLargeInts[I] ;
        vQry2Endereco.Params[1].AsStrings[I] := Value[I].endereco.DsCep;
      end;

      vConexao.conexao.StartTransaction;
      try
        vQry2Endereco.Execute(Value.Count, 0);
        vConexao.conexao.Commit;
        Result := True;
      except
        vConexao.conexao.Rollback;
        Result := False;
      end;

      if Result then
      begin
        vQry3EnderecoInt.Connection := vConexao.conexao;
        vQry3EnderecoInt.SQL.Clear;
        vQry3EnderecoInt.SQL.Text := vInsertEnderecoIntegracao;

        vQry3EnderecoInt.Params[0].DataType := ftLargeint;
        vQry3EnderecoInt.Params.ArraySize := Value.Count;

        for I := 0 to Value.Count - 1 do
        begin
          vQry3EnderecoInt.Params[0].AsLargeInts[I] := vQry2Endereco.Params[2].AsLargeInts[I] ;
        end;

        vConexao.conexao.StartTransaction;
        try
          vQry3EnderecoInt.Execute(Value.Count, 0);
          vConexao.conexao.Commit;
          Result := True;
        except
          vConexao.conexao.Rollback;
          Result := False;
        end;
      end;

    end;

  finally
    vQryPessoa.Free;
    vQry2Endereco.Free;
    vQry3EnderecoInt.Free;
  end;

  TThread.CreateAnonymousThread(
      procedure
    begin
      TEnderecosDAO.AtualizarVazios;
    end).Start;

end;

function TDAOPessoa<T>.Update(Value: T): T;
const
  vUpdatePessoa = 'UPDATE public.pessoa ' +
    'SET flnatureza=:flnatureza, dsdocumento=:dsdocumento, nmprimeiro=:nmprimeiro, nmsegundo=:nmsegundo, dtregistro=:dtregistro '
    + 'WHERE idpessoa=:idpessoa; ';
  vUpdateEndereco = 'UPDATE public.endereco ' + 'SET dscep=:dscep ' +
    'WHERE idendereco=:idendereco; ';
var
  vConexao: iConexao;
begin
  vConexao := TConexao.New('PRINCIPAL');
  vConexao.conexao.StartTransaction;
  try
    vConexao.conexao.ExecSQL(vUpdatePessoa,
      [Value.FlNatureza, Value.DsDocumento, Value.NmPrimeiro, Value.NmSegundo,
      Value.DtRegistro, Value.IdPessoa],
      [ftSmallint, ftString, ftString, ftString, ftDate, ftLargeint]);

    vConexao.conexao.ExecSQL(vUpdateEndereco,
      [Value.endereco.DsCep, Value.endereco.IdEndereco],
      [ftString, ftLargeint]);
    vConexao.conexao.Commit;
  except
    vConexao.conexao.Rollback;
  end;

  TThread.CreateAnonymousThread(
    procedure
    begin
      TEnderecosDAO.AtualizarModificado(Value.endereco.DsCep,
        Value.endereco.IdEndereco);
    end).Start;

  Result := Value;
end;

end.
