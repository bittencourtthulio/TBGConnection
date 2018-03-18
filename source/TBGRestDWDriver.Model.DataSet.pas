unit TBGRestDWDriver.Model.DataSet;

interface

uses
  TBGConnection.Model.DataSet.Interfaces, Data.DB, uRESTDWPoolerDB, TBGConnection.Model.DataSet.Observer;

Type
  TConnectionModelRestDWDataSet = class(TInterfacedObject, iDataSet, ICacheDataSetObserver)
    private
      FDataSet : TRESTDWClientSQL;
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

{ TConnectionModelRestDWDataSet }

constructor TConnectionModelRestDWDataSet.Create(Observer : ICacheDataSetSubject);
begin
  FDataSet := TRESTDWClientSQL.Create(nil);
  FGUUID :=  TGUID.NewGuid.ToString;
  FObserver := Observer;
  FObserver.AddObserver(Self);
end;

function TConnectionModelRestDWDataSet.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TConnectionModelRestDWDataSet.DataSet(Value: TDataSet): iDataSet;
begin
  Result := Self;
  if Assigned(FDataSet) then
    FreeAndNil(FDataSet);
  FDataSet := TRESTDWClientSQL(Value);
end;

destructor TConnectionModelRestDWDataSet.Destroy;
begin
  FObserver.RemoveObserver(Self);
  FreeAndNil(FDataSet);
  inherited;
end;

function TConnectionModelRestDWDataSet.GUUID: String;
begin
  Result := FGUUID;
end;

class function TConnectionModelRestDWDataSet.New(Observer : ICacheDataSetSubject) : iDataSet;
begin
  Result := Self.Create(Observer);
end;

function TConnectionModelRestDWDataSet.SQL: String;
begin
  Result := FSQL;
end;

function TConnectionModelRestDWDataSet.SQL(Value: String): iDataSet;
begin
  Result := Self;
  FSQL := Value;
end;

function TConnectionModelRestDWDataSet.Update(Value: String): ICacheDataSetObserver;
begin
  Result := Self;
  if FGUUID <> Value then
    if FDataSet.State in [dsBrowse] then
      FDataSet.Refresh;
end;

end.
