unit TBGInterbaseExpressDriver.Model.Query;

interface
uses
  TBGConnection.Model.Interfaces, System.Classes, System.SysUtils,
  Data.DB, IBX.IBDatabase, IBX.IBCustomDataSet, IBX.IBQuery,
  Datasnap.Provider, Datasnap.DBCLient,
  TBGConnection.Model.DataSet.Proxy, TBGConnection.Model.DataSet.Interfaces,
  TBGConnection.Model.DataSet.Observer, System.Generics.Collections;

Type
  TInterbaseExpressModelQuery = class(TComponent, iQuery)
    private
      FConexao : TIBDatabase;
      FiConexao : iConexao;
      FDriver : iDriver;
      FQuery : TList<TIBQuery>;
      DataSetProvider1: TList<TDataSetProvider>;
      ClientDataSet1: TList<TClientDataSet>;
      FKey : Integer;
      FDataSource : TDataSource;
      FDataSet : TDictionary<integer, iDataSet>;
      FChangeDataSet : TChangeDataSet;
      FSQL : String;
      procedure InstanciaQuery;
      function GetDataSet : iDataSet;
      function GetCDS : TClientDataSet;
      function GetQuery : TIBQuery;
    public
      constructor Create(Conexao : TIBDatabase; Driver : iDriver);
      destructor Destroy; override;
      class function New(Conexao : TIBDatabase; Driver : iDriver) : iQuery;
      //iQuery
      function Open(aSQL: String): iQuery;
      function ExecSQL(aSQL : String) : iQuery; overload;
      function DataSet : TDataSet; overload;
      function DataSet(Value : TDataSet) : iQuery; overload;
      function DataSource(Value : TDataSource) : iQuery;
      function Fields : TFields;
      function &End: TComponent;
      procedure ApplyUpdates(DataSet : TDataSet);
      procedure RealoadCache(DataSet : TDataSet);
      function Tag(Value : Integer) : iQuery;
      function LocalSQL(Value : TComponent) : iQuery;
      function Close : iQuery;
      function SQL : TStrings;
      function Params : TParams;
      function ParamByName(Value : String) : TParam;
      function ExecSQL : iQuery; overload;
      function UpdateTableName(Tabela : String) : iQuery;
  end;

implementation


{ TDBExpressModelQuery }

procedure TInterbaseExpressModelQuery.ApplyUpdates(DataSet: TDataSet);
begin
  GetCDS.ApplyUpdates(0);
  FDriver.Cache.ReloadCache('');
end;

function TInterbaseExpressModelQuery.Close: iQuery;
begin
  Result := Self;
  GetQuery.Close;
end;

constructor TInterbaseExpressModelQuery.Create(Conexao: TIBDatabase; Driver: iDriver);
begin
  FDriver := Driver;
  FConexao := Conexao;
  FQuery := TList<TIBQuery>.Create;
  FDataSet := TDictionary<integer, iDataSet>.Create;
  DataSetProvider1 := TList<TDataSetProvider>.Create;
  ClientDataSet1  := TList<TClientDataSet>.Create;
end;

function TInterbaseExpressModelQuery.DataSet: TDataSet;
begin
  Result := TDataSet(GetCDS);
end;

function TInterbaseExpressModelQuery.DataSet(Value: TDataSet): iQuery;
begin
  Result := Self;
  GetDataSet.DataSet(Value);
end;

function TInterbaseExpressModelQuery.DataSource(Value: TDataSource): iQuery;
begin
  Result := Self;
  FDataSource := Value;
end;

destructor TInterbaseExpressModelQuery.Destroy;
begin
  FreeAndNil(DataSetProvider1);
  FreeAndNil(ClientDataSet1);
  FreeAndNil(FQuery);
  FreeAndNil(FDataSet);
  FreeAndNil(DataSetProvider1);
  FreeAndNil(ClientDataSet1);
  inherited;
end;

function TInterbaseExpressModelQuery.&End: TComponent;
begin
  Result := GetQuery;
end;

function TInterbaseExpressModelQuery.ExecSQL: iQuery;
begin
  Result := Self;
  GetQuery.ExecSQL;
  RealoadCache(nil);
end;

function TInterbaseExpressModelQuery.ExecSQL(aSQL: String): iQuery;
begin
  FSQL := aSQL;
  GetQuery.SQL.Text := FSQL;
  GetQuery.ExecSQL;
  RealoadCache(nil);
end;

function TInterbaseExpressModelQuery.Fields: TFields;
begin
  Result := GetCDS.Fields;
end;

function TInterbaseExpressModelQuery.GetCDS: TClientDataSet;
begin
  Result := ClientDataSet1.Items[Pred(ClientDataSet1.Count)];
end;

function TInterbaseExpressModelQuery.GetDataSet: iDataSet;
begin
  Result := FDataSet.Items[FKey];
end;

function TInterbaseExpressModelQuery.GetQuery: TIBQuery;
begin
  if FQuery.Count = 0 then
    InstanciaQuery;

  Result := FQuery.Items[Pred(FQuery.Count)]
end;

procedure TInterbaseExpressModelQuery.InstanciaQuery;
var
  Query : TIBQuery;
  Provider : TDataSetProvider;
  ClientDataSet : TClientDataSet;
begin
  Query := TIBQuery.Create(Self);
  Query.Database := FConexao;
  Provider := TDataSetProvider.Create(Self);
  ClientDataSet := TClientDataSet.Create(Self);
  Provider.DataSet := Query;
  Provider.Options := [poAllowCommandText];
  Provider.Name := 'Provider' + FormatDateTime('nnss', now);
  ClientDataSet.ProviderName := Provider.Name;
  ClientDataSet.FetchOnDemand := true;
  ClientDataSet.AfterPost := ApplyUpdates;
  ClientDataSet.AfterDelete := ApplyUpdates;
  DataSetProvider1.Add(Provider);
  ClientDataSet1.Add(ClientDataSet);
  FQuery.Add(Query);
end;

function TInterbaseExpressModelQuery.LocalSQL(Value: TComponent): iQuery;
begin
  Result := Self;
  raise Exception.Create('Função não suportada por este driver');
end;

class function TInterbaseExpressModelQuery.New(Conexao: TIBDatabase;
  Driver: iDriver): iQuery;
begin
  Result := Self.Create(Conexao, Driver);
end;

function TInterbaseExpressModelQuery.Open(aSQL: String): iQuery;
var
  Query : TIBQuery;
  DataSet : iDataSet;
begin
  Result := Self;
  FSQL := aSQL;
  if not FDriver.Cache.CacheDataSet(FSQL, DataSet) then
  begin
    InstanciaQuery;
    DataSet.SQL(FSQL);
    DataSet.DataSet(GetCDS);
    GetCDS.Close;
    GetCDS.CommandText := FSQL;
    GetCDS.Open;
    FDriver.Cache.AddCacheDataSet(DataSet.GUUID, DataSet);
  end;
  FDataSource.DataSet := DataSet.DataSet;
  Inc(FKey);
  FDataSet.Add(FKey, DataSet);
end;


function TInterbaseExpressModelQuery.ParamByName(Value: String): TParam;
begin
  Result := GetQuery.ParamByName(Value);
end;

function TInterbaseExpressModelQuery.Params: TParams;
begin
  Result := GetQuery.Params;
end;

procedure TInterbaseExpressModelQuery.RealoadCache(DataSet: TDataSet);
begin
   FDriver.Cache.ReloadCache('');
end;

function TInterbaseExpressModelQuery.SQL: TStrings;
begin
  Result := GetQuery.SQL;
end;

function TInterbaseExpressModelQuery.Tag(Value: Integer): iQuery;
begin
  Result := Self;
  GetQuery.Tag := Value;
end;

function TInterbaseExpressModelQuery.UpdateTableName(Tabela: String): iQuery;
begin
  Result := Self;
end;

end.
