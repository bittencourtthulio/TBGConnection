unit TBGInterbaseExpressDriver.Model.DataSet;

interface
uses
  TBGConnection.Model.DataSet.Interfaces,
  Data.DB, IBX.IBCustomDataSet, IBX.IBQuery,
  TBGConnection.Model.DataSet.Observer;

Type
  TConnectionModelInterbaseExpressDataSet = class(TInterfacedObject, iDataSet, ICacheDataSetObserver)
    private
      FDataSet : TIBQuery;
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

{ TConnectionModelInterbaseExpressDataSet }

constructor TConnectionModelInterbaseExpressDataSet.Create(
  Observer: ICacheDataSetSubject);
begin
  FDataSet := TIBQuery.Create(nil);
  FGUUID :=  TGUID.NewGuid.ToString;
  FObserver := Observer;
  FObserver.AddObserver(Self);
end;

function TConnectionModelInterbaseExpressDataSet.DataSet(
  Value: TDataSet): iDataSet;
begin
  Result := Self;
  if Assigned(FDataSet) then
    FreeAndNil(FDataSet);
  FDataSet := TIBQuery(Value);
end;

function TConnectionModelInterbaseExpressDataSet.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

destructor TConnectionModelInterbaseExpressDataSet.Destroy;
begin

  inherited;
end;

function TConnectionModelInterbaseExpressDataSet.GUUID: String;
begin
  Result := FGUUID;
end;

class function TConnectionModelInterbaseExpressDataSet.New(
  Observer: ICacheDataSetSubject): iDataSet;
begin
  Result := Self.Create(Observer);
end;

function TConnectionModelInterbaseExpressDataSet.SQL(Value: String): iDataSet;
begin
  Result := Self;
  FSQL := Value;
end;

function TConnectionModelInterbaseExpressDataSet.SQL: String;
begin
  Result := FSQL;
end;

function TConnectionModelInterbaseExpressDataSet.Update(
  Value: String): ICacheDataSetObserver;
begin
  Result := Self;
  if FGUUID <> Value then
    if FDataSet.State in [dsBrowse] then
      FDataSet.Refresh;
end;

end.
