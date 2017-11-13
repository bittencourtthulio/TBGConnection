unit TBGZeosDriver.Model.DataSet;

interface

uses
  TBGConnection.Model.DataSet.Interfaces, Data.DB,
  TBGConnection.Model.DataSet.Observer, ZDataset;

Type
  TConnectionModelZeosDataSet = class(TInterfacedObject, iDataSet, ICacheDataSetObserver)
    private
      FDataSet : TZQuery;
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

{ TConnectionModelZeosDataSet }

constructor TConnectionModelZeosDataSet.Create(Observer : ICacheDataSetSubject);
begin
  FDataSet := TZQuery.Create(nil);
  FGUUID :=  TGUID.NewGuid.ToString;
  FObserver := Observer;
  FObserver.AddObserver(Self);
end;

function TConnectionModelZeosDataSet.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TConnectionModelZeosDataSet.DataSet(Value: TDataSet): iDataSet;
begin
  Result := Self;
  if Assigned(FDataSet) then
    FreeAndNil(FDataSet);
  FDataSet := TZQuery(Value);
end;

destructor TConnectionModelZeosDataSet.Destroy;
begin
  FObserver.RemoveObserver(Self);
  FreeAndNil(FDataSet);
  inherited;
end;

function TConnectionModelZeosDataSet.GUUID: String;
begin
  Result := FGUUID;
end;

class function TConnectionModelZeosDataSet.New(Observer : ICacheDataSetSubject) : iDataSet;
begin
  Result := Self.Create(Observer);
end;

function TConnectionModelZeosDataSet.SQL: String;
begin
  Result := FSQL;
end;

function TConnectionModelZeosDataSet.SQL(Value: String): iDataSet;
begin
  Result := Self;
  FSQL := Value;
end;

function TConnectionModelZeosDataSet.Update(Value: String): ICacheDataSetObserver;
begin
  Result := Self;
  if FGUUID <> Value then
    if FDataSet.State in [dsBrowse] then
      FDataSet.Refresh;
end;

end.
