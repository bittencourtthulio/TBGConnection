unit TBGFirebaseConnection.Model.CM.Send;

interface

uses
  TBGFirebaseConnection.Interfaces,
  Data.DB,
  System.Classes,
  System.Notification,
  System.PushNotification,
  {$IFDEF ANDROID}FMX.PushNotification.Android, {$ENDIF}
  {$IFDEF IOS} FMX.PushNotification.iOS,{$ENDIF}
  System.Threading,
  TBGFirebaseConnection.Model.CM.Register,
  Datasnap.DBClient;

Type
  TFirebaseCloudMessage = class(TInterfacedObject, iFirebaseCloudMessage)
  private
    FPushService: TPushService;
    ServiceConnection: TPushServiceConnection;
    FRemetenteCode : String;
    FAPIKey : String;
    FDeviceList : TStringList;
    FMessage : String;
    FCMRegister : iFirebaseCloudMessageRegistration;
    FBaseURL : String;
    FAuth : String;
    FUID : String;
    procedure GetFirebaseListDevice(var aDeviceList : TStringList);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iFirebaseCloudMessage;

    //SendMessage
    function RemetenteCode(aCode: String): iFirebaseCloudMessage;
    function BaseURL( aBaseURL : String ) : iFirebaseCloudMessage;
    function Auth ( aAuth : String ) : iFirebaseCloudMessage;
    function UID ( aUID : String ) : iFirebaseCloudMessage;
    function APIKey(aApi: String): iFirebaseCloudMessage;
    function AddDeviceAPI(aDeviceToken: String): iFirebaseCloudMessage;
    function AddDeviceList(aDeviceList: TStringList): iFirebaseCloudMessage;
    function SendMessage(aMessage: String): iFirebaseCloudMessage;
    function Send: iFirebaseCloudMessage;
    function RegisterPush : iFirebaseCloudMessageRegistration;
  end;

implementation

uses
  System.JSON, System.Net.HttpClient, System.SysUtils,
  TBGFirebaseConnection.View.Connection;

const
  URL_FIREBASE : String = 'https://fcm.googleapis.com/fcm/send';

{ TFirebaseCloudMessage }

function TFirebaseCloudMessage.AddDeviceAPI(
  aDeviceToken: String): iFirebaseCloudMessage;
begin
  Result := Self;
  FDeviceList.Add(aDeviceToken);
end;

function TFirebaseCloudMessage.AddDeviceList(
  aDeviceList: TStringList): iFirebaseCloudMessage;
begin
  Result := Self;
  FDeviceList := aDeviceList;
end;

function TFirebaseCloudMessage.APIKey(aApi: String): iFirebaseCloudMessage;
begin
  Result := Self;
  FAPIKey := aAPI;
end;

function TFirebaseCloudMessage.Auth(aAuth: String): iFirebaseCloudMessage;
begin
  Result := Self;
  FAuth := aAuth;
end;

function TFirebaseCloudMessage.BaseURL(aBaseURL: String): iFirebaseCloudMessage;
begin
  Result := Self;
  FBaseURL := aBaseURL;
end;

constructor TFirebaseCloudMessage.Create;
begin
  FCMRegister := TFirebaseCMRegister.New;
  if not Assigned(FDeviceList) then
    FDeviceList := TStringList.Create;
end;

destructor TFirebaseCloudMessage.Destroy;
begin
  if Assigned(FDeviceList) then
    FDeviceList.Free;
  inherited;
end;

procedure TFirebaseCloudMessage.GetFirebaseListDevice(
  var aDeviceList: TStringList);
var
  Firebase : TTBGFirebaseConnection;
  DataSet : TClientDataSet;
  aJsonArray : TJsonArray;
begin
  Firebase := TTBGFirebaseConnection.Create;
  DataSet := TClientDataSet.Create(nil);
  try
    Firebase
    .Connect
      .BaseURL(FBaseURL)
      .Auth(FAuth)
      .uId(FUID)
    .&End
    .Get
      .Resource('Apps')
      .DataSet(DataSet)
      .ResponseContent(aJsonArray)
    .&End
    .Exec;

    DataSet.First;
    while not DataSet.Eof do
    begin
      aDeviceList.Add(DataSet.FieldByName('TOKEN').AsString);
      DataSet.Next;
    end;

  finally
    Firebase.DisposeOf;
  end;

end;

class function TFirebaseCloudMessage.New: iFirebaseCloudMessage;
begin
  Result := Self.Create;
end;

function TFirebaseCloudMessage.RegisterPush: iFirebaseCloudMessageRegistration;
begin
  Result := FCMRegister;
end;

function TFirebaseCloudMessage.RemetenteCode(
  aCode: String): iFirebaseCloudMessage;
begin
  Result := Self;
  FRemetenteCode := aCode;
end;

function TFirebaseCloudMessage.Send: iFirebaseCloudMessage;
var
  IdList : TJSONArray;
  JsonMessage, JsonSend : TJSONObject;
  I: Integer;
  HTTPClient : THTTPClient;
  Stream, Response : TStringStream;
begin
  IdList := TJSONArray.Create;

  if FDeviceList.Count = 0 then
    GetFirebaseListDevice(FDeviceList);

  for I := 0 to Pred(FDeviceList.Count) do
      IdList.Add(FDeviceList[I]);

  JsonMessage := TJSONObject.Create;
  JsonMessage.AddPair('id', FRemetenteCode);
  JsonMessage.AddPair('message', FMessage);

  JsonSend := TJSONObject.Create;
  JsonSend.AddPair('registration_ids', IdList);
  JsonSend.AddPair('data', JsonMessage);

  HTTPClient := THTTPClient.Create;
  HTTPClient.ContentType := 'application/json';
  HTTPClient.CustomHeaders['Authorization'] := 'key=' + FAPIKey;


  Stream := TStringStream.Create(JsonSend.ToString);
  Stream.Position := 0;

  Response := TStringStream.Create;

  HTTPClient.Post(URL_FIREBASE, Stream, Response);
  Response.Position := 0;

  FDeviceList.Clear;
end;

function TFirebaseCloudMessage.SendMessage(
  aMessage: String): iFirebaseCloudMessage;
begin
  Result := Self;
  FMessage := aMessage;
end;

function TFirebaseCloudMessage.UID(aUID: String): iFirebaseCloudMessage;
begin
  Result := Self;
  FUID := aUID;
end;

end.
