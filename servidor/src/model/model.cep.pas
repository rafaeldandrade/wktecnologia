unit model.cep;

interface

type
  TCEP = class
  private
    Fcep: String;
    Flogradouro: String;
    Fcomplemento: String;
    Fbairro: String;
    Flocalidade: String;
    Fuf: String;
    Fibge: String;
    Fgia: String;
    Fddd: String;
    Fsiafi: String;
  public
    property cep: String read Fcep write Fcep;
    property logradouro: String read Flogradouro write Flogradouro;
    property complemento: String read Fcomplemento write Fcomplemento;
    property bairro: String read Fbairro write Fbairro;
    property localidade: String read Flocalidade write Flocalidade;
    property uf: String read Fuf write Fuf;
    property ibge: String read Fibge write Fibge;
    property gia: String read Fgia write Fgia;
    property ddd: String read Fddd write Fddd;
    property siafi: String read Fsiafi write Fsiafi;
  end;

implementation

end.
