unit model.entity.endereco;

interface

type
  TEndereco = class
  private
    FIdEndereco: Int64;
    FDsCep: String;
    FDsUF: String;
    FNmCidade: String;
    FNmBairro: String;
    FNmLogradouro: String;
    FDsComplemento: String;
  public
    property IdEndereco: Int64 read FIdEndereco write FIdEndereco;
    property DsCep: String read FDsCep write FDsCep;
    property DsUF: String read FDsUF write FDsUF;
    property NmCidade: String read FNmCidade write FNmCidade;
    property NmBairro: String read FNmBairro write FNmBairro;
    property NmLogradouro: String read FNmLogradouro write FNmLogradouro;
    property DsComplemento: String read FDsComplemento write FDsComplemento;

    class function New: TEndereco;
  end;

implementation

{ TEndereco }

class function TEndereco.New: TEndereco;
begin
  Result := Self.Create;
end;

end.
