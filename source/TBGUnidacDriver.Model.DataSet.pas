unit TBGUnidacDriver.Model.DataSet;

interface

uses
  TBGConnection.Model.DataSet.Interfaces, Data.DB,
  TBGConnection.Model.DataSet.Observer, MemDS, DBAccess, Uni;

Type
  TConnectionModelUnidacDataSet = class(TInterfacedObject, iDataSet, ICacheDataSetObserver)
    private
      FDataSet : TUniQuery;
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

{ TConnectionModelUnidacDataSet }

constructor TConnectionModelUnidacDataSet.Create(Observer : ICacheDataSetSubject);
begin
  FDataSet := TUniQuery.Create(nil);
  FGUUID :=  TGUID.NewGuid.ToString;
  FObserver := Observer;
  FObserver.AddObserver(Self);
end;

function TConnectionModelUnidacDataSet.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TConnectionModelUnidacDataSet.DataSet(Value: TDataSet): iDataSet;
begin
  Result := Self;
  if Assigned(FDataSet) then
    FreeAndNil(FDataSet);
  FDataSet := TUniQuery(Value);
end;

destructor TConnectionModelUnidacDataSet.Destroy;
begin
  FObserver.RemoveObserver(Self);
  FreeAndNil(FDataSet);
  inherited;
end;

function TConnectionModelUnidacDataSet.GUUID: String;
begin
  Result := FGUUID;
end;

class function TConnectionModelUnidacDataSet.New(Observer : ICacheDataSetSubject) : iDataSet;
begin
  Result := Self.Create(Observer);
end;

function TConnectionModelUnidacDataSet.SQL: String;
begin
  Result := FSQL;
end;

function TConnectionModelUnidacDataSet.SQL(Value: String): iDataSet;
begin
  Result := Self;
  FSQL := Value;
end;

function TConnectionModelUnidacDataSet.Update(Value: String): ICacheDataSetObserver;
begin
  Result := Self;
  if FGUUID <> Value then
    if FDataSet.State in [dsBrowse] then
      FDataSet.Refresh;
end;

end.
