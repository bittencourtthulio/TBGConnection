unit TBGFirebaseConnection.Interfaces;

interface

uses System.JSON, Data.DB, System.Classes;

type
  iFirebaseConnect = interface;
  iFirebasePut = interface;
  iFirebaseGet = interface;
  iFirebasePatch = interface;
  iFirebaseDelete = interface;
  iFirebaseCloudMessage = interface;
  iFirebaseCloudMessageRegistration = interface;

  iFirebaseConnection = interface
    ['{D24B1AB1-2AA9-46E3-8DB8-5CB550A2BD17}']
    function Connect : iFirebaseConnect;
    function Put : iFirebasePut;
    function Get : iFirebaseGet;
    function Patch : iFirebasePatch;
    function Delete : iFirebaseDelete;
    function CloudMessage : iFirebaseCloudMessage;
    procedure &Exec;
  end;

  iFirebaseConnect = interface
    ['{CAABD8E2-3530-4D50-9EBB-225B45E6A686}']
    function BaseURL (Value : String) : iFirebaseConnect; overload;
    function Auth (Value : String) : iFirebaseConnect; overload;
    function uId (Value : String) : iFirebaseConnect; overload;
    function BaseURL : String; overload;
    function Auth : String; overload;
    function uId : String; overload;
    function &End : iFirebaseConnection;
  end;

  iFirebasePut = interface
    ['{15826039-2077-4FA3-A952-5F6EE716664E}']
    function Resource ( Value : String) : iFirebasePut; overload;
    function Resource : String; overload;
    function Json ( Value : String) : iFirebasePut; overload;
    function Json ( Value : TJsonObject) : iFirebasePut; overload;
    function Json ( Value : TJsonArray ) : iFirebasePut; overload;
    function Json : String; overload;
    function &End : iFirebaseConnection;
  end;

  iFirebasePatch = interface
    ['{15826039-2077-4FA3-A952-5F6EE716664E}']
    function Resource ( Value : String) : iFirebasePatch; overload;
    function Resource : String; overload;
    function Json ( Value : String) : iFirebasePatch; overload;
    function Json ( Value : TJsonObject) : iFirebasePatch; overload;
    function Json : String; overload;
    function &End : iFirebaseConnection;
  end;

  iFirebaseDelete = interface
    ['{15826039-2077-4FA3-A952-5F6EE716664E}']
    function Resource ( Value : String) : iFirebaseDelete; overload;
    function Resource : String; overload;
    function Json ( Value : String) : iFirebaseDelete; overload;
    function Json ( Value : TJsonObject) : iFirebaseDelete; overload;
    function Json : String; overload;
    function &End : iFirebaseConnection;
  end;

  iFirebaseGet = interface
    ['{42656C46-ADD4-4F7D-AA15-DB4E9437CF55}']
    function DataSet ( Value : TDataSet ) : iFirebaseGet; overload;
    function DataSet : TDataSet; overload;
    function ResponseContent(var aResponse : String ) : iFirebaseGet; overload;
    function ResponseContent(var aJsonArray : TJsonArray) : iFirebaseGet; overload;
    function ResponseContent(var aJsonObject : TJsonObject) : iFirebaseGet; overload;
    function Resource (Value : String) : iFirebaseGet; overload;
    function Resource : String; overload;
    function &End : iFirebaseConnection;
  end;

  iFirebaseCloudMessage = interface
    ['{4B4EBB38-10D2-4CAA-812C-3A0A900DFFA5}']
    function BaseURL( aBaseURL : String ) : iFirebaseCloudMessage;
    function Auth ( aAuth : String ) : iFirebaseCloudMessage;
    function UID ( aUID : String ) : iFirebaseCloudMessage;
    function RemetenteCode(aCode : String) : iFirebaseCloudMessage;
    function APIKey(aApi : String) : iFirebaseCloudMessage;
    function AddDeviceAPI(aDeviceToken : String) : iFirebaseCloudMessage;
    function AddDeviceList(aDeviceList : TStringList) : iFirebaseCloudMessage;
    function SendMessage(aMessage : String) : iFirebaseCloudMessage;
    function Send : iFirebaseCloudMessage;
    function RegisterPush : iFirebaseCloudMessageRegistration;
  end;

  iFirebaseCloudMessageRegistration = interface
    ['{CCBA59F7-2B91-4F92-8323-4C7610B6C873}']
    function RegisterPushService : iFirebaseCloudMessageRegistration;
    function BaseURL(aURL : String) : iFirebaseCloudMessageRegistration;
    function Auth(aAuth : String) : iFirebaseCloudMessageRegistration;
    function uID(aUID : String) : iFirebaseCloudMessageRegistration;
    function Resource(aResource : String) : iFirebaseCloudMessageRegistration;
    function RemetenteCode(aCode : String) : iFirebaseCloudMessageRegistration;
  end;

implementation

end.
