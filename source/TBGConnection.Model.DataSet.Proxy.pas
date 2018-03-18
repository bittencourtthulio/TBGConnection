unit TBGConnection.Model.DataSet.Proxy;

interface

uses
  Classes, TBGConnection.Model.Interfaces, System.Generics.Collections, Data.DB,
  TBGConnection.Model.DataSet.Interfaces;

Type
  TTBGConnectionModelProxy = class(TInterfacedObject, iDriverProxy)
    private
      FCacheDataSet : TDictionary<string, iDataSet>;
      FObserver : ICacheDataSetSubject;
      FLimitCacheRegister : Integer;
      FDriver : iDriver;
    procedure LimiterCache;
    public
      constructor Create(LimitCacheRegister : Integer; Driver : iDriver);
      destructor Destroy; override;
      class function New(LimitCacheRegister : Integer; Driver : iDriver) : iDriverProxy;
      function CacheDataSet(Key : String; var Value : iDataSet) : boolean;
      function AddCacheDataSet(Key : String; Value : iDataSet) : iDriverProxy;
      function RemoveCache(Key : String) : iDriverProxy;
      function ClearCache : iDriverProxy;
      function ReloadCache(Value : String) : iDriverProxy;
      function ObserverList : ICacheDataSetSubject;
  end;

implementation

uses
  System.SysUtils, TBGConnection.Model.DataSet.Factory,
  TBGConnection.Model.DataSet.Observer;

{ TTBGConnectionModelProxy }

function TTBGConnectionModelProxy.AddCacheDataSet(Key: String;
  Value: iDataSet): iDriverProxy;
begin
  FCacheDataSet.Add(Key, Value);
  LimiterCache;
end;

function TTBGConnectionModelProxy.CacheDataSet(Key: String;
  var Value: iDataSet): boolean;
var
  Chave : String;
  DataSet : iDataSet;
begin
  Result := false;
  if FCacheDataSet.Count > 0 then
  begin
    for Chave in FCacheDataSet.Keys do
      if FCacheDataSet.Items[Chave].SQL = Key then
      begin
        Value := FCacheDataSet.Items[Chave];
        Result := true;
      end;
  end;

  if not Assigned(Value) then
  begin
    Value := FDriver.DataSet;// TConnectionModelDataSetFactory.New.DataSet(FObserver);
  end;

end;

function TTBGConnectionModelProxy.ClearCache: iDriverProxy;
begin
  FCacheDataSet.Clear;
end;

constructor TTBGConnectionModelProxy.Create(LimitCacheRegister : Integer; Driver : iDriver);
begin
  FCacheDataSet := TDictionary<string, iDataSet>.Create;
  FObserver := TConnectionModelDataSetObserver.New;
  FLimitCacheRegister := LimitCacheRegister;
  FDriver := Driver;
end;

destructor TTBGConnectionModelProxy.Destroy;
begin
  FreeAndNil(FCacheDataSet);
  inherited;
end;

class function TTBGConnectionModelProxy.New(LimitCacheRegister : Integer; Driver : iDriver) : iDriverProxy;
begin
  Result := Self.Create(LimitCacheRegister, Driver);
end;

function TTBGConnectionModelProxy.ObserverList: ICacheDataSetSubject;
begin
  Result := FObserver;
end;

function TTBGConnectionModelProxy.ReloadCache(Value: String): iDriverProxy;
begin
  Result := Self;
  FObserver.Notify(Value);
end;

procedure TTBGConnectionModelProxy.LimiterCache;
var
  Key : String;
begin
  while FCacheDataSet.Count > FLimitCacheRegister do
  begin
    for Key in FCacheDataSet.Keys do
    begin
      FCacheDataSet.Remove(Key);
      FCacheDataSet.TrimExcess;
      Break;
    end;
  end;
end;

function TTBGConnectionModelProxy.RemoveCache(Key: String): iDriverProxy;
begin
  FCacheDataSet.Remove(Key);
  FCacheDataSet.TrimExcess;
end;

end.
