unit TBGUnidacDriver.Model.Query;

interface

uses
  TBGConnection.Model.Interfaces, Data.DB, System.Classes,
  System.SysUtils, MemDS, DBAccess, Uni;

Type
  TUnidacModelQuery = class(TInterfacedObject, iQuery)
  private
    FConexao: TUniConnection;
    FQuery: TUniQuery;
    FDataSource: TDataSource;
    FDataSet: TDataSet;
    FChangeDataSet: TChangeDataSet;
  public
    constructor Create(Conexao: TUniConnection);
    destructor Destroy; override;
    class function New(Conexao: TUniConnection): iQuery;
    // iQuery
    function Open(aSQL: String): iQuery;
    function ExecSQL(aSQL: String): iQuery;
    function DataSet: TDataSet; overload;
    function DataSet(Value: TDataSet): iQuery; overload;
    function DataSource(Value: TDataSource): iQuery;
    function Fields: TFields;
    function ChangeDataSet(Value: TChangeDataSet): iQuery;
    function &End: TComponent;
    function Tag(Value: Integer): iQuery;
    function LocalSQL(Value: TComponent): iQuery;
  end;

implementation

{ TUnidacModelQuery }

function TUnidacModelQuery.&End: TComponent;
begin
  Result := FQuery;
end;

function TUnidacModelQuery.ExecSQL(aSQL: String): iQuery;
begin
  FQuery.SQL.Clear;
  FQuery.SQL.Add(aSQL);
  FQuery.ExecSQL;
end;

function TUnidacModelQuery.Fields: TFields;
begin
  Result := FQuery.Fields;
end;

function TUnidacModelQuery.LocalSQL(Value: TComponent): iQuery;
begin
  Result := Self;
  raise Exception.Create('Função não suportada por este driver');
end;

function TUnidacModelQuery.ChangeDataSet(Value: TChangeDataSet): iQuery;
begin
  Result := Self;
  FChangeDataSet := Value;
end;

constructor TUnidacModelQuery.Create(Conexao: TUniConnection);
begin
  FConexao := Conexao;
  FQuery := TUniQuery.Create(nil);
  FQuery.Connection := FConexao;
end;

function TUnidacModelQuery.DataSet: TDataSet;
begin
  Result := TDataSet(FQuery);
end;

function TUnidacModelQuery.DataSet(Value: TDataSet): iQuery;
begin
  Result := Self;
  FDataSet := Value;
end;

function TUnidacModelQuery.DataSource(Value: TDataSource): iQuery;
begin
  Result := Self;
  FDataSource := Value;
end;

destructor TUnidacModelQuery.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

class function TUnidacModelQuery.New(Conexao: TUniConnection): iQuery;
begin
  Result := Self.Create(Conexao);
end;

function TUnidacModelQuery.Open(aSQL: String): iQuery;
begin

  if not(Assigned(FDataSource) or Assigned(FDataSet)) then
    raise Exception.Create
      ('Não Foi Instanciado um Container DataSet/DataSource');

  if Assigned(FDataSource) then
    FDataSource.DataSet := FQuery;

  if Assigned(FDataSet) then
    FDataSet := FQuery;

  Result := Self;
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(aSQL);
  FQuery.Open;

end;

function TUnidacModelQuery.Tag(Value: Integer): iQuery;
begin
  Result := Self;
  FQuery.Tag := Value;
end;

end.
