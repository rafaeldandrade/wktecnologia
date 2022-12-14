unit server.webmodule;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker,
  Datasnap.DSServer,
  Web.WebFileDispatcher,
  Web.HTTPProd,
  Datasnap.DSAuth,
  Datasnap.DSProxyJavaScript,
  IPPeerServer,
  Datasnap.DSMetadata,
  Datasnap.DSServerMetadata,
  Datasnap.DSClientMetadata,
  Datasnap.DSCommonServer,
  Datasnap.DSHTTP,
  System.JSON,
  Data.DBXCommon;

type
  TWebModule1 = class(TWebModule)
    DSRESTWebDispatcher1: TDSRESTWebDispatcher;
    WebFileDispatcher1: TWebFileDispatcher;
    DSProxyGenerator1: TDSProxyGenerator;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebFileDispatcher1BeforeDispatch(Sender: TObject;
      const AFileName: string; Request: TWebRequest; Response: TWebResponse;
      var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure DSRESTWebDispatcher1FormatResult(Sender: TObject;
      var ResultVal: TJSONValue; const Command: TDBXCommand;
      var Handled: Boolean);
    procedure DSRESTWebDispatcher1NameMap(Sender: TObject;
      const RequestType, ClassName, MethodName: string;
      var DSMethodName: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses
  server.methods.pessoa,
  server.container,
  Web.WebReq;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := '<html>' + '<head><title>DataSnap Server</title></head>' +
    '<body>DataSnap Server</body>' + '</html>';
end;

procedure TWebModule1.DSRESTWebDispatcher1FormatResult(Sender: TObject;
  var ResultVal: TJSONValue; const Command: TDBXCommand; var Handled: Boolean);
var
  lcvJSONValue: TJSONValue;
begin
  lcvJSONValue := ResultVal;
  try
    ResultVal := TJSONArray(lcvJSONValue).Remove(0);
  Finally
    lcvJSONValue.Free;
  end;
  Handled := True;
end;

procedure TWebModule1.DSRESTWebDispatcher1NameMap(Sender: TObject;
  const RequestType, ClassName, MethodName: string; var DSMethodName: string);
begin
  if ClassName.Equals('cadastro') then
  begin
    if RequestType.Equals('GET') then
    begin
      DSMethodName := 'TCadastro.' + MethodName;
    end else
    if RequestType.Equals('PUT') then
    begin
      DSMethodName := 'TCadastro.accept' + MethodName;
    end else
    if RequestType.Equals('POST') then
    begin
      DSMethodName := 'TCadastro.update' + MethodName;
    end else
    if RequestType.Equals('DELETE') then
    begin
      DSMethodName := 'TCadastro.cancel' + MethodName;
    end;
  end;
end;

procedure TWebModule1.WebFileDispatcher1BeforeDispatch(Sender: TObject;
  const AFileName: string; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
var
  D1, D2: TDateTime;
begin
  Handled := False;
  if SameFileName(ExtractFileName(AFileName), 'serverfunctions.js') then
    if not FileExists(AFileName) or
      (FileAge(AFileName, D1) and FileAge(WebApplicationFileName, D2) and
        (D1 < D2)) then
    begin
      DSProxyGenerator1.TargetDirectory := ExtractFilePath(AFileName);
      DSProxyGenerator1.TargetUnitName := ExtractFileName(AFileName);
      DSProxyGenerator1.Write;
    end;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  DSServerMetaDataProvider1.server := DSServer;
  DSRESTWebDispatcher1.server := DSServer;
  if DSServer.Started then
  begin
    DSRESTWebDispatcher1.DbxContext := DSServer.DbxContext;
    DSRESTWebDispatcher1.Start;
  end;
end;

initialization

finalization

Web.WebReq.FreeWebModules;

end.
