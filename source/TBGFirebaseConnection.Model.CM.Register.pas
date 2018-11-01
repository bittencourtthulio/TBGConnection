unit TBGFirebaseConnection.Model.CM.Register;

interface

uses
  TBGFirebaseConnection.Interfaces,
  System.Classes,
  System.Notification,
  System.PushNotification,
  {$IFDEF ANDROID}FMX.PushNotification.Android, {$ENDIF}
  {$IFDEF IOS} FMX.PushNotification.iOS,{$ENDIF}
  System.Threading;

Type
  TFirebaseCMRegister = class(TInterfacedObject, iFirebaseCloudMessageRegistration)
    private
      FBaseURL : String;
      FAuth : String;
      FUID : String;
      FResource : String;
      FRemetenteCode : String;
      FPushService: TPushService;
      ServiceConnection: TPushServiceConnection;
      procedure RegisterAppFirebase( aId : String; aToken : String);
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFirebaseCloudMessageRegistration;
      procedure DoServiceConnectionChange(Sender: TObject; PushChanges: TPushService.TChanges);
      procedure DoReceiveNotificationEvent(Sender: TObject; const ServiceNotification: TPushServiceNotification);
      function RegisterPushService : iFirebaseCloudMessageRegistration;
      function ActivePushService: iFirebaseCloudMessageRegistration;
      function BaseURL(aURL : String) : iFirebaseCloudMessageRegistration;
      function Auth(aAuth : String) : iFirebaseCloudMessageRegistration;
      function uID(aUID : String) : iFirebaseCloudMessageRegistration;
      function Resource(aResource : String) : iFirebaseCloudMessageRegistration;
      function RemetenteCode(aCode : String) : iFirebaseCloudMessageRegistration;
  end;

implementation

uses
  System.JSON, System.Net.HttpClient, System.SysUtils,
  TBGFirebaseConnection.View.Connection, Datasnap.DBClient, Data.DB;

{ TFirebaseCMRegister }

function TFirebaseCMRegister.ActivePushService: iFirebaseCloudMessageRegistration;
begin
  Result := Self;
  {$IFDEF IOS}
    PushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.APS);
    ServiceConnection := TPushServiceConnection.Create(PushService);
    ServiceConnection.OnChange := DoServiceConnectionChange;
    ServiceConnection.OnReceiveNotification := DoReceiveNotificationEvent;
    TTask.run(
      procedure
      begin
        ServiceConnection.Active := True;
      end);
  {$ELSE}
  FPushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.GCM);
  FPushService.AppProps[TPushService.TAppPropNames.GCMAppID] := FRemetenteCode;
  ServiceConnection := TPushServiceConnection.Create(FPushService);
  ServiceConnection.OnChange := DoServiceConnectionChange;
  ServiceConnection.OnReceiveNotification := DoReceiveNotificationEvent;

  TTask.run(
    procedure
    begin
      ServiceConnection.Active := True;
    end);

{$ENDIF}
end;

function TFirebaseCMRegister.Auth(
  aAuth: String): iFirebaseCloudMessageRegistration;
begin
  Result := Self;
  FAuth := aAuth;
end;

function TFirebaseCMRegister.BaseURL(
  aURL: String): iFirebaseCloudMessageRegistration;
begin
  Result := Self;
  FBaseURL := aURL;
end;

constructor TFirebaseCMRegister.Create;
begin

end;

destructor TFirebaseCMRegister.Destroy;
begin

  inherited;
end;

procedure TFirebaseCMRegister.DoReceiveNotificationEvent(Sender: TObject;
  const ServiceNotification: TPushServiceNotification);
var
  MessageText: string;
  x: Integer;
  obj: TJSONObject;
  MyJSONPair: TJSONPair;
begin
  try
    for x := 0 to ServiceNotification.DataObject.Count - 1 do
    begin
      if ServiceNotification.DataKey = 'aps' then
        if ServiceNotification.DataObject.Pairs[x].JsonString.Value = 'alert' then
          MessageText := ServiceNotification.DataObject.Pairs[x].JsonValue.Value;

      if ServiceNotification.DataKey = 'gcm' then
        if ServiceNotification.DataObject.Pairs[x].JsonString.Value = 'message' then
          MessageText := ServiceNotification.DataObject.Pairs[x].JsonValue.Value;
    end;

  except
    on e : exception do
      raise Exception.Create(E.Message);
  end;

end;

procedure TFirebaseCMRegister.DoServiceConnectionChange(Sender: TObject;
  PushChanges: TPushService.TChanges);
var
  device_token,
  device_id : string;
begin
  if TPushService.TChange.DeviceToken in PushChanges then
    device_token := FPushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken];
    device_id := FPushService.DeviceIDValue[TPushService.TDeviceIDNames.DeviceID];

  RegisterAppFirebase(device_id, device_token);

end;

class function TFirebaseCMRegister.New: iFirebaseCloudMessageRegistration;
begin
  Result := Self.Create;
end;

procedure TFirebaseCMRegister.RegisterAppFirebase(aId, aToken: String);
var
  Firebase : TTBGFirebaseConnection;
  Json : TJsonObject;
  JsonArray : TJsonArray;
  ResponseJson : String;
  FDataSet : TClientDataSet;
  FExist : Boolean;
begin
  FExist := false;
  Json := TJsonObject.Create;
  Firebase := TTBGFirebaseConnection.Create;
  FDataSet := TClientDataSet.Create(nil);
  try
    Firebase
    .Connect
      .BaseURL(FBaseURL)
      .Auth(FAuth)
      .uId(FUID)
    .&End
    .Get
      .Resource('Apps')
      .ResponseContent(JsonArray)
      .DataSet(FDataSet)
    .&End
    .Exec;

    try
      FDataSet.Filtered := False;
      FDataSet.Filter :=  'DEVICE = ' + QuotedStr(aId);
      FDataSet.Filtered := True;
      FExist := true;
    except
      //Nao existe registro cadastrado
    end;


    if ((not FExist) or (FDataSet.FieldByName('DEVICE').AsString <> aID)) then
    begin
      if not Assigned(JsonArray) then JsonArray := TJSONArray.Create;
      
      JsonArray
      .AddElement(
        Json
              .AddPair('DEVICE', aId)
              .AddPair('TOKEN', aToken)
      );


      Firebase
      .Connect
        .BaseURL(FBaseURL)
        .Auth(FAuth)
        .uId(FUID)
      .&End
      .Put
        .Resource('Apps')
        .Json(JsonArray)
      .&End;

    end;


  finally
    if Assigned(Firebase)   then Firebase.DisposeOf;
    if Assigned(Json)       then Json.DisposeOf;
    if Assigned(JsonArray)  then JsonArray.DisposeOf;
    if Assigned(FDataSet)   then FDataSet.DisposeOf;

  end;
end;

function TFirebaseCMRegister.RegisterPushService: iFirebaseCloudMessageRegistration;
begin
  FPushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.GCM);
  FPushService.AppProps[TPushService.TAppPropNames.GCMAppID] := FRemetenteCode;
  ServiceConnection := TPushServiceConnection.Create(FPushService);
  ServiceConnection.OnChange := DoServiceConnectionChange;
  ServiceConnection.OnReceiveNotification := DoReceiveNotificationEvent;
  ActivePushService;
end;

function TFirebaseCMRegister.RemetenteCode(
  aCode: String): iFirebaseCloudMessageRegistration;
begin
  Result := Self;
  FRemetenteCode := aCode;
end;

function TFirebaseCMRegister.Resource(
  aResource: String): iFirebaseCloudMessageRegistration;
begin
  Result := Self;
  FResource := aResource;
end;

function TFirebaseCMRegister.uID(
  aUID: String): iFirebaseCloudMessageRegistration;
begin
  Result := Self;
  FUID := aUID;
end;

end.
