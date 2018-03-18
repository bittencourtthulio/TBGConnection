unit TBGUnidacDriver.Model.Query;

interface

uses
  TBGConnection.Model.Interfaces, Data.DB, System.Classes,
  System.SysUtils, MemDS, DBAccess, Uni,
  TBGConnection.Model.DataSet.Interfaces,
  TBGConnection.Model.DataSet.Proxy,
  TBGConnection.Model.DataSet.Observer, System.Generics.Collections;

Type
  TUnidacModelQuery = class(TInterfacedObject, iQuery)
  private
    FConexao: TUniConnection;
    FKey : Integer;
    FiConexao : iConexao;
    FDriver : iDriver;
    FQuery: TList<TUniQuery>;
    FDataSource: TDataSource;
    FDataSet: TDictionary<integer, iDataSet>;
    FChangeDataSet: TChangeDataSet;
    FSQL : String;
    FGetDataSet: iDataSet;
    FParams : TParams;
    procedure InstanciaQuery;
    function GetDataSet : iDataSet;
    function GetQuery : TUniQuery;
  public
    constructor Create(Conexao: TUniConnection; Driver : iDriver);
    destructor Destroy; override;
    class function New(Conexao: TUniConnection; Driver : iDriver): iQuery;
    //iObserver
    procedure ApplyUpdates(DataSet : TDataSet);
    // iQuery
    function Open(aSQL: String): iQuery;
    function ExecSQL(aSQL: String): iQuery; overload;
    function DataSet: TDataSet; overload;
    function DataSet(Value: TDataSet): iQuery; overload;
    function DataSource(Value: TDataSource): iQuery;
    function Fields: TFields;
    function ChangeDataSet(Value: TChangeDataSet): iQuery;
    function &End: TComponent;
    function Tag(Value: Integer): iQuery;
    function LocalSQL(Value: TComponent): iQuery;
    function Close : iQuery;
    function SQL : TStrings;
    function Params : TParams;
    function ExecSQL : iQuery; overload;
    function ParamByName(Value : String) : TParam;
    function UpdateTableName(Tabela : String) : iQuery;
  end;

implementation

{ TUnidacModelQuery }

function TUnidacModelQuery.&End: TComponent;
begin
  Result := GetQuery;
end;

function TUnidacModelQuery.ExecSQL: iQuery;
begin
  Result := Self;
  GetQuery.ExecSQL;
  ApplyUpdates(nil);
end;

function TUnidacModelQuery.ExecSQL(aSQL: String): iQuery;
begin
  GetQuery.SQL.Clear;
  GetQuery.SQL.Add(aSQL);
  GetQuery.ExecSQL;
  ApplyUpdates(nil);
end;

function TUnidacModelQuery.Fields: TFields;
begin
  Result := GetQuery.Fields;
end;

function TUnidacModelQuery.GetDataSet : iDataSet;
begin
  Result := FDataSet.Items[FKey];
end;

function TUnidacModelQuery.GetQuery: TUniQuery;
begin
  Result := FQuery.Items[Pred(FQuery.Count)];
end;

procedure TUnidacModelQuery.InstanciaQuery;
var
  Query : TUniQuery;
begin
  Query := TUniQuery.Create(nil);
  Query.Connection := FConexao;
  Query.AfterPost := ApplyUpdates;
  Query.AfterDelete := ApplyUpdates;
  FQuery.Add(Query);
end;

function TUnidacModelQuery.LocalSQL(Value: TComponent): iQuery;
begin
  Result := Self;
  raise Exception.Create('Função não suportada por este driver');
end;

procedure TUnidacModelQuery.ApplyUpdates(DataSet: TDataSet);
begin
  FDriver.Cache.ReloadCache('');
end;

function TUnidacModelQuery.ChangeDataSet(Value: TChangeDataSet): iQuery;
begin
  Result := Self;
  FChangeDataSet := Value;
end;

function TUnidacModelQuery.Close: iQuery;
begin
  Result := Self;
  GetQuery.Close;
end;

constructor TUnidacModelQuery.Create(Conexao: TUniConnection; Driver : iDriver);
begin
  FDriver := Driver;
  FConexao := Conexao;
  FQuery := TList<TUniQuery>.Create;
  FDataSet := TDictionary<integer, iDataSet>.Create;
  InstanciaQuery;
end;

function TUnidacModelQuery.DataSet: TDataSet;
begin
  Result := TDataSet(GetQuery);
end;

function TUnidacModelQuery.DataSet(Value: TDataSet): iQuery;
begin
  Result := Self;
  GetDataSet.DataSet(Value);
end;

function TUnidacModelQuery.DataSource(Value: TDataSource): iQuery;
begin
  Result := Self;
  FDataSource := Value;
end;

destructor TUnidacModelQuery.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FDataSet);
  inherited;
end;

class function TUnidacModelQuery.New(Conexao: TUniConnection; Driver : iDriver): iQuery;
begin
  Result := Self.Create(Conexao, Driver);
end;

function TUnidacModelQuery.Open(aSQL: String): iQuery;
var
  Query : TUniQuery;
  DataSet : iDataSet;
begin
  Result := Self;
  FSQL := aSQL;
  if not FDriver.Cache.CacheDataSet(FSQL, DataSet) then
  begin
    InstanciaQuery;
    DataSet.SQL(FSQL);
    DataSet.DataSet(GetQuery);
    GetQuery.Close;
    GetQuery.SQL.Text := FSQL;
    GetQuery.Open;
    FDriver.Cache.AddCacheDataSet(DataSet.GUUID, DataSet);
  end;
  FDataSource.DataSet := DataSet.DataSet;
  Inc(FKey);
  FDataSet.Add(FKey, DataSet);
end;

function TUnidacModelQuery.ParamByName(Value: String): TParam;
begin
  Result := GetQuery.ParamByName(Value);
end;

function TUnidacModelQuery.Params: TParams;
begin
  Result := GetQuery.Params;
end;

function TUnidacModelQuery.SQL: TStrings;
begin
  Result := GetQuery.SQL;
end;

function TUnidacModelQuery.Tag(Value: Integer): iQuery;
begin
  Result := Self;
  GetQuery.Tag := Value;
end;

function TUnidacModelQuery.UpdateTableName(Tabela: String): iQuery;
begin
  Result := Self;
end;

end.
