unit TBGFirebaseConnection.Model.Get;

interface

uses
  TBGFirebaseConnection.Interfaces,
  Data.DB,
  Data.DBXJSONReflect,
  REST.Client,
  REST.Types,
  REST.JSON,
  REST.Response.Adapter,
  IpPeerClient,
  System.JSON;

Type
  TFirebaseConnectionModelGet = class(TInterfacedObject, iFirebaseGet)
  private
    FParent : iFirebaseConnection;
    FDataSet : TDataSet;
    FResource : String;
    FRESTRequest : TRESTRequest;
    FRESTResponse : TRESTResponse;
    FRESTClient : TRESTClient;
    FRESTResponseDataSetAdapter : TRESTResponseDataSetAdapter;
    FResponseJson: string;
    FResponseJsonArray : ^TJSONArray;
    FResponseJsonObject : ^TJSONObject;
  public
    constructor Create(Parent : iFirebaseConnection);
    destructor Destroy; override;
    class function New(Parent : iFirebaseConnection) : iFirebaseGet;
    function DataSet(Value: TDataSet): iFirebaseGet; overload;
    function DataSet: TDataSet; overload;
    function Resource(Value: String): iFirebaseGet; overload;
    function Resource: String; overload;
    function ResponseContent(var aResponse : String ) : iFirebaseGet; overload;
    function ResponseContent(var aJsonArray : TJsonArray) : iFirebaseGet; overload;
    function ResponseContent(var aJsonObject : TJsonObject) : iFirebaseGet; overload;
    function &End: iFirebaseConnection;
  end;

implementation

uses
  System.SysUtils;

{ TFirebaseConnectionModelGet }

function TFirebaseConnectionModelGet.&End: iFirebaseConnection;
begin
  Result := FParent;
  try
    FRESTResponseDataSetAdapter.Dataset := FDataSet;
    FRESTClient.BaseURL := FParent.Connect.BaseURL;
    FRESTRequest.Method := rmGET;
    FRESTRequest.resource := FResource;
    FRESTRequest.Execute;
    FResponseJson := FRESTResponse.Content;

    try
      if FResponseJson <> 'null' then
        if Copy(FResponseJson, 0, 1) = '[' then
          FResponseJsonArray^ := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FResponseJson),0) as TJSONArray
        else
          FResponseJsonObject^ := TJSONObject.ParseJSONValue(FResponseJson) as TJSONObject;
    except
      //not result
    end;


    if Assigned(FDataSet) then
    begin
      FRESTResponseDataSetAdapter.Active := true;
      FDataSet.Active := True;
    end;

  except
    raise Exception.Create('Erro ao Consultar a Base de Dados');
  end;
end;

constructor TFirebaseConnectionModelGet.Create(Parent : iFirebaseConnection);
begin
  FResponseJsonArray := nil;
  FParent := Parent;
  FRESTRequest := TRESTRequest.Create(nil);
  FRESTResponse := TRESTResponse.Create(FRESTRequest);
  FRESTClient := TRESTClient.Create(FParent.Connect.BaseURL);
  FRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  FRESTClient.AcceptEncoding := 'identity';
  FRESTRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRESTRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  FRESTRequest.AcceptEncoding := 'identity';
  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Response := FRESTResponse;
  //FMemTable := TFDMemTable.Create(FRESTRequest);
  FRESTResponseDataSetAdapter := TRESTResponseDataSetAdapter.Create(FRESTRequest);
  //FRESTResponseDataSetAdapter.Dataset := FMemTable;
  FRESTResponseDataSetAdapter.Response := FRESTResponse;
end;

function TFirebaseConnectionModelGet.DataSet(Value: TDataSet): iFirebaseGet;
begin
  Result := Self;
  FDataSet := Value;
end;

function TFirebaseConnectionModelGet.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

destructor TFirebaseConnectionModelGet.Destroy;
begin

  inherited;
end;

class function TFirebaseConnectionModelGet.New(Parent : iFirebaseConnection) : iFirebaseGet;
begin
  Result := Self.Create(Parent);
end;

function TFirebaseConnectionModelGet.Resource(Value: String): iFirebaseGet;
begin
  Result := Self;
  FResource := '/' + Value + '.json';
end;

function TFirebaseConnectionModelGet.Resource: String;
begin
  Result := FResource;
end;

function TFirebaseConnectionModelGet.ResponseContent(
  var aJsonObject: TJsonObject): iFirebaseGet;
begin
  Result := Self;
  FResponseJsonObject := @aJsonObject;
end;

function TFirebaseConnectionModelGet.ResponseContent(var
  aJsonArray: TJsonArray): iFirebaseGet;
begin
  Result := Self;
  FResponseJsonArray := @aJsonArray;
end;

function TFirebaseConnectionModelGet.ResponseContent(var
  aResponse: String): iFirebaseGet;
begin
  Result := Self;
  FResponseJson := aResponse;
end;

end.
