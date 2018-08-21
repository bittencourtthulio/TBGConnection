unit TBGInterbaseExpressDriver.View.Driver;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes, TBGConnection.Model.Conexao.Parametros,
  System.Generics.Collections,
  IBX.IBDatabase, IBX.IBQuery,
  TBGConnection.Model.DataSet.Interfaces;

Type
  TBGInterbaseExpressDriverConexao = class(TComponent, iDriver)
  private
    FFConnection: TIBDatabase;
    FFQuery: TIBQuery;
    FiConexao : iConexao;
    FiQuery : TList<iQuery>;
    FLimitCacheRegister : Integer;
    FProxy : iDriverProxy;
    procedure SetFConnection(const Value: TIBDatabase);
    procedure SetFQuery(const Value: TIBQuery);
    function GetLimitCache: Integer;
    procedure SetLimitCache(const Value: Integer);
    protected
      FParametros : iConexaoParametros;
      function Conexao : iConexao;
      function Query : iQuery;
      function Cache : iDriverProxy;
      function DataSet : iDataSet;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDriver;
      function Conectar : iConexao;
      function &End: TComponent;
      function Parametros: iConexaoParametros;
      function LimitCacheRegister(Value : Integer) : iDriver;
    published
      property FConnection : TIBDatabase read FFConnection write SetFConnection;
      property LimitCache : Integer read GetLimitCache write SetLimitCache;
  end;

procedure Register;

implementation

uses
  System.SysUtils, TBGInterbaseExpressDriver.Model.Query,
  TBGInterbaseExpressDriver.Model.Conexao, TBGConnection.Model.DataSet.Proxy,
  TBGInterbaseExpressDriver.Model.DataSet;

{ TBGDBExpressDriverConexao }


function TBGInterbaseExpressDriverConexao.Cache: iDriverProxy;
begin
  if not Assigned(FProxy) then
    FProxy := TTBGConnectionModelProxy.New(FLimitCacheRegister, Self);

  Result := FProxy;
end;

function TBGInterbaseExpressDriverConexao.Conectar: iConexao;
begin

end;

function TBGInterbaseExpressDriverConexao.Conexao: iConexao;
begin
  if not Assigned(FiConexao) then
    FiConexao := TInterbaseExpressDriverModelConexao.New(FFConnection, FLimitCacheRegister, Self);
  Result := FiConexao;
end;

constructor TBGInterbaseExpressDriverConexao.Create;
begin
  FiQuery := TList<iQuery>.Create;
end;

function TBGInterbaseExpressDriverConexao.DataSet: iDataSet;
begin
  if not Assigned(FProxy) then
    FProxy := TTBGConnectionModelProxy.New(FLimitCacheRegister, Self);

  Result := TConnectionModelInterbaseExpressDataSet.New(FProxy.ObserverList);
end;

destructor TBGInterbaseExpressDriverConexao.Destroy;
begin
  FreeAndNil(FiQuery);
  inherited;
end;

function TBGInterbaseExpressDriverConexao.&End: TComponent;
begin

end;

function TBGInterbaseExpressDriverConexao.GetLimitCache: Integer;
begin
  Result := FLimitCacheRegister;
end;

function TBGInterbaseExpressDriverConexao.LimitCacheRegister(Value: Integer): iDriver;
begin
  Result := Self;
  FLimitCacheRegister := Value;
end;

class function TBGInterbaseExpressDriverConexao.New: iDriver;
begin
  Result := Self.Create;
end;

function TBGInterbaseExpressDriverConexao.Parametros: iConexaoParametros;
begin
  Result := FParametros;
end;

function TBGInterbaseExpressDriverConexao.Query: iQuery;
begin
  if Not Assigned(FiQuery) then
    FiQuery := TList<iQuery>.Create;

  if Not Assigned(FiConexao) then
    FiConexao := TInterbaseExpressDriverModelConexao.New(FFConnection, FLimitCacheRegister, Self);

  FiQuery.Add(TInterbaseExpressModelQuery.New(FFConnection, Self));
  Result := FiQuery[FiQuery.Count-1];
end;

procedure TBGInterbaseExpressDriverConexao.SetFConnection(const Value: TIBDatabase);
begin
  FFConnection := Value;
end;

procedure TBGInterbaseExpressDriverConexao.SetFQuery(const Value: TIBQuery);
begin
  FFQuery := Value;
end;

procedure TBGInterbaseExpressDriverConexao.SetLimitCache(const Value: Integer);
begin
   FLimitCacheRegister := Value;
end;

procedure Register;
begin
  RegisterComponents('TBGAbstractConnection', [TBGInterbaseExpressDriverConexao]);
end;

end.
