unit server.container;

interface

uses
  System.SysUtils,
  System.Classes,
  Datasnap.DSServer,
  Datasnap.DSCommonServer,
  IPPeerServer,
  IPPeerAPI,
  Datasnap.DSAuth,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Phys,
  FireDAC.Comp.Client,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys.PGDef,
  FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Phys.PG,
  Data.DB;

type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSServerClass1: TDSServerClass;
    FDManager1: TFDManager;
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    procedure ConfigurarServidor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

function DSServer: TDSServer;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses
  server.methods.pessoa;

var
  FModule: TComponent;
  FDSServer: TDSServer;

function DSServer: TDSServer;
begin
  Result := FDSServer;
end;

procedure TServerContainer1.ConfigurarServidor;
var
  vParams: TStrings;
begin
  vParams := TStringList.Create;
  try
    vParams.Add('Pooled=True');
    vParams.Add('Database=testewk');
    vParams.Add('User_Name=postgres');
    vParams.Add('Password=Innovation@@#');
    vParams.Add('Server=localhost');
    vParams.Add('Port=5432');
    vParams.Add('CharacterSet=UTF8');
    vParams.Add('ExtendedMetadata=True');
    vParams.Add('ApplicationName=APITesteWK');
    vParams.Add('PoolMax=200');
    vParams.Add('PoolExp=5400000');
    vParams.Add('PoolCeanup=2700000');

    FDManager1.AddConnectionDef('PRINCIPAL', 'PG', vParams);
  finally
    vParams.Free;
  end;

end;

constructor TServerContainer1.Create(AOwner: TComponent);
begin
  inherited;
  FDSServer := DSServer1;

  ConfigurarServidor;
end;

destructor TServerContainer1.Destroy;
begin
  inherited;
  FDSServer := nil;
end;

procedure TServerContainer1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := server.methods.pessoa.TCadastro;
end;

initialization

FModule := TServerContainer1.Create(nil);

finalization

FModule.Free;

end.
