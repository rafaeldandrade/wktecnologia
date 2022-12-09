unit model.utils;

interface

uses
  System.SysUtils,
  System.TypInfo,
  System.Generics.Collections,
  REST.JSON,
  System.JSON,
  model.enums;

type
  TNaturezaPessoaHelper = record helper for TNaturezaPessoa
    function ToEnum(Value: String): TNaturezaPessoa;
    function ToString: String;
  end;

  TUtils = class
  public
    class function ObjectListToJSON<T: class>(const aObjects: TObjectList<T>): TJSONArray;
    class function JsonToObjectList<T: class, constructor>(const aText: string): TObjectList<T>;
    class function ObjectToJSON<T: class>(aObject: T): TJSONObject;
    class function JSONToObject<T: class, constructor>(const aText: String): T;
  end;

implementation

{ TNaturezaPessoaHelper }

function TNaturezaPessoaHelper.ToEnum(Value: String): TNaturezaPessoa;
begin
  Result := TNaturezaPessoa(GetEnumValue(TypeInfo(TNaturezaPessoa), UpperCase(Value)));
end;

function TNaturezaPessoaHelper.ToString: String;
begin
  Result := GetEnumName(TypeInfo(TNaturezaPessoa), Integer(Self));
end;

{ TUtils }

class function TUtils.JSONToObject<T>(const aText: String): T;
var
  vJsonObject: TJSONObject;
begin
  vJsonObject :=  TJSONObject.ParseJSONValue(aText) as TJSONObject;
  try
    if vJsonObject = nil then
        raise Exception.Create('Invalid JSON');
    Result := TJson.JsonToObject<T>(TJSONObject(vJsonObject));
  finally
    vJsonObject.Free;
  end;
end;

class function TUtils.JsonToObjectList<T>(const aText: string): TObjectList<T>;
var
  vObject: T;
  vArray: TJSONArray;
  vValue: TJSONValue;
  vList: TObjectList<T>;
begin
  vList := TObjectList<T>.Create;
  vArray := nil;
  try
    vArray := TJSONObject.ParseJSONValue(aText) as TJSONArray;
    if vArray = nil then
      raise Exception.Create('Invalid JSON');
    for vValue in vArray do
      if vValue is TJSONObject then
      begin
        vObject := TJson.JsonToObject<T>(TJSONObject(vValue));
        vList.Add(vObject);
      end;
    Result := vList;
    vList := nil;
  finally
    vArray.Free;
    vList.Free;
  end;
end;

class function TUtils.ObjectListToJSON<T>(
  const aObjects: TObjectList<T>): TJSONArray;
var
  vObject: T;
  vArray: TJSONArray;
  vValue: T;
  vElement: TJSONObject;
begin
  vArray := TJSONArray.Create;
  try
    for vObject in AObjects do
    begin
      vElement := TJson.ObjectToJsonObject(vObject);
      vArray.AddElement(vElement);
    end;
    Result := vArray;
    vArray := nil;
  finally
    vArray.Free;
  end;

end;

class function TUtils.ObjectToJSON<T>(aObject: T): TJSONObject;
begin
  Result := TJson.ObjectToJsonObject(aObject);
end;

end.
