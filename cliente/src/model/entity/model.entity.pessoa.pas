unit model.entity.pessoa;

interface

uses
  model.entity.endereco,
  model.enums;

type
  TPessoa = class
  private
    FIdPessoa: Int64;
    FFlNatureza: TNaturezaPessoa;
    FDsDocumento: String;
    FNmPrimeiro: String;
    FNmSegundo: String;
    FDtRegistro: TDate;
    FEndereco: TEndereco;
    function GetDsCEP: String;
  public
    property IdPessoa: Int64 read FIdPessoa write FIdPessoa;
    property FlNatureza: TNaturezaPessoa read FFlNatureza write FFlNatureza;
    property DsDocumento: String read FDsDocumento write FDsDocumento;
    property NmPrimeiro: String read FNmPrimeiro write FNmPrimeiro;
    property NmSegundo: String read FNmSegundo write FNmSegundo;
    property DtRegistro: TDate read FDtRegistro write FDtRegistro;
    property DsCEP: String read GetDsCEP;
    property endereco: TEndereco read FEndereco write FEndereco;

    constructor Create;
    destructor Destroy; override;
    class function New: TPessoa;
  end;

implementation

{ TPessoa }

constructor TPessoa.Create;
begin
  FEndereco := TEndereco.New;
end;

destructor TPessoa.Destroy;
begin
  FEndereco.Free;
  inherited;
end;

function TPessoa.GetDsCEP: String;
begin
  Result := FEndereco.DsCEP;
end;

class function TPessoa.New: TPessoa;
begin
  Result := Self.Create;
end;

end.