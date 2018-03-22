unit TBGFirebaseConnection.Model.Delete;

interface

uses
  TBGFirebaseConnection.Interfaces,
  System.JSON,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  System.Net.HttpClient;

Type
  TFirebaseConnectionModelDelete = class(TInterfacedObject, iFirebaseDelete)
  private
    FParent : iFirebaseConnection;
    FResource : String;
    FJson : TJsonObject;
    FJson2 : String;
  public
    constructor Create(Parent : iFirebaseConnection);
    destructor Destroy; override;
    class function New(Parent : iFirebaseConnection): iFirebaseDelete;
    function Resource(Value: String): iFirebaseDelete; overload;
    function Resource: String; overload;
    function Json(Value: String): iFirebaseDelete; overload;
    function Json(Value: TJsonObject): iFirebaseDelete; overload;
    function Json: String; overload;
    function &End: iFirebaseConnection;
  end;

implementation

uses
  System.SysUtils, System.Classes;

{ TFirebaseConnectionModelDelete }

function TFirebaseConnectionModelDelete.&End: iFirebaseConnection;
var
  lJsonStream: TStringStream;
  lIdHTTP: THTTPClient;
  lResponse: string;
  lUrl: string;
  AResponseContent : TStringStream;
begin
  Result := FParent;
  try
    //lJsonStream := TStringStream.Create(Utf8Encode(FJson.ToJSON));
    lIdHTTP := THTTPClient.Create;
    lIdHTTP.CustomHeaders['auth'] := FParent.Connect.Auth;
    lIdHTTP.CustomHeaders['uid'] := FParent.Connect.uId;
    lIdHTTP.ContentType := 'application/json';
    lUrl := FParent.Connect.BaseURL + FResource;
    AResponseContent := TStringStream.Create();
    lIdHTTP.Delete(lUrl, AResponseContent);
  except
    raise Exception.Create('Não foi possivel realizar o Delete na Base de Dados');
  end;

end;

constructor TFirebaseConnectionModelDelete.Create(Parent : iFirebaseConnection);
begin
  FParent := Parent;
end;

destructor TFirebaseConnectionModelDelete.Destroy;
begin

  inherited;
end;

function TFirebaseConnectionModelDelete.Json: String;
begin
  Result := FJson.ToString;
end;

function TFirebaseConnectionModelDelete.Json(Value: TJsonObject): iFirebaseDelete;
begin
  Result := Self;
  FJson := Value;
end;

function TFirebaseConnectionModelDelete.Json(Value: String): iFirebaseDelete;
begin
  Result := Self;
  FJson := TJSONObject.ParseJSONValue(Value) as TJSONObject;
end;

class function TFirebaseConnectionModelDelete.New(Parent : iFirebaseConnection): iFirebaseDelete;
begin
  Result := Self.Create(Parent);
end;

function TFirebaseConnectionModelDelete.Resource: String;
begin
  Result := FResource;
end;

function TFirebaseConnectionModelDelete.Resource(Value: String): iFirebaseDelete;
begin
  Result := Self;
  FResource := '/' + Value + '.json';
end;

end.
