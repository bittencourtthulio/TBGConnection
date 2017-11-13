unit TBGDBExpressDriver.Model.DataSet;

interface

uses
  TBGConnection.Model.DataSet.Interfaces, Data.DB,
  TBGConnection.Model.DataSet.Observer, Data.SqlExpr;

Type
  TConnectionModelDBExpressDataSet = class(TInterfacedObject, iDataSet, ICacheDataSetObserver)
    private
      FDataSet : TSQLQuery;
      FObserver : ICacheDataSetSubject;
      FGUUID : String;
      FSQL : String;
    public
      constructor Create(Observer : ICacheDataSetSubject);
      destructor Destroy; override;
      class function New(Observer : ICacheDataSetSubject) : iDataSet;
      function DataSet : TDataSet; overload;
      function DataSet (Value : TDataSet) : iDataSet; overload;
      function GUUID : String;
      function SQL : String; overload;
      function SQL (Value : String) : iDataSet; overload;
      function Update(Value : String) : ICacheDataSetObserver;
  end;

implementation

uses
  System.SysUtils;

{ TConnectionModelDBExpressDataSet }

constructor TConnectionModelDBExpressDataSet.Create(Observer : ICacheDataSetSubject);
begin
  FDataSet := TSQLQuery.Create(nil);
  FGUUID :=  TGUID.NewGuid.ToString;
  FObserver := Observer;
  FObserver.AddObserver(Self);
end;

function TConnectionModelDBExpressDataSet.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TConnectionModelDBExpressDataSet.DataSet(Value: TDataSet): iDataSet;
begin
  Result := Self;
  if Assigned(FDataSet) then
    FreeAndNil(FDataSet);
  FDataSet := TSQLQuery(Value);
end;

destructor TConnectionModelDBExpressDataSet.Destroy;
begin
  FObserver.RemoveObserver(Self);
  FreeAndNil(FDataSet);
  inherited;
end;

function TConnectionModelDBExpressDataSet.GUUID: String;
begin
  Result := FGUUID;
end;

class function TConnectionModelDBExpressDataSet.New(Observer : ICacheDataSetSubject) : iDataSet;
begin
  Result := Self.Create(Observer);
end;

function TConnectionModelDBExpressDataSet.SQL: String;
begin
  Result := FSQL;
end;

function TConnectionModelDBExpressDataSet.SQL(Value: String): iDataSet;
begin
  Result := Self;
  FSQL := Value;
end;

function TConnectionModelDBExpressDataSet.Update(Value: String): ICacheDataSetObserver;
begin
  Result := Self;
  if FGUUID <> Value then
    if FDataSet.State in [dsBrowse] then
      FDataSet.Refresh;
end;

end.
