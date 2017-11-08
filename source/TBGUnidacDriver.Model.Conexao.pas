unit TBGUnidacDriver.Model.Conexao;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes, Data.DB, MemDS, DBAccess, Uni,
  TBGConnection.Model.DataSet.Interfaces;

Type
  TUnidacDriverModelConexao = class(TInterfacedObject, iConexao)
    private
      FConnection : TUniConnection;
      FCache : iDriverProxy;
    public
      constructor Create(Connection : TUniConnection; LimitCacheRegister : Integer);
      destructor Destroy; override;
      class function New(Connection : TUniConnection; LimitCacheRegister : Integer) : iConexao;
      //iConexao
      function Cache : iDriverProxy;
      function Conectar : iConexao;
      function &End: TComponent;
      function Connection : TCustomConnection;
      function StartTransaction : iConexao;
      function RollbackTransaction : iConexao;
      function Commit : iConexao;
  end;

implementation

uses
  TBGConnection.Model.DataSet.Proxy;

{ TUnidacDriverModelConexao }

function TUnidacDriverModelConexao.Cache: iDriverProxy;
begin
  Result := FCache;
end;

function TUnidacDriverModelConexao.Commit: iConexao;
begin
  Result := Self;
  FConnection.Commit;
end;

function TUnidacDriverModelConexao.Conectar: iConexao;
begin
  Result := Self;
  FConnection.Connected := true;
end;

function TUnidacDriverModelConexao.&End: TComponent;
begin
  Result := FConnection;
end;

function TUnidacDriverModelConexao.Connection: TCustomConnection;
begin
  Result := FConnection;
end;

constructor TUnidacDriverModelConexao.Create(Connection : TUniConnection; LimitCacheRegister : Integer);
begin
  FConnection := Connection;
  FCache := TTBGConnectionModelProxy.New(LimitCacheRegister);
end;

destructor TUnidacDriverModelConexao.Destroy;
begin

  inherited;
end;

class function TUnidacDriverModelConexao.New(Connection : TUniConnection; LimitCacheRegister : Integer) : iConexao;
begin
  Result := Self.Create(Connection, LimitCacheRegister);
end;

function TUnidacDriverModelConexao.RollbackTransaction: iConexao;
begin
  Result := Self;
  FConnection.Rollback;
end;

function TUnidacDriverModelConexao.StartTransaction: iConexao;
begin
  Result := Self;
  FConnection.StartTransaction;
end;

end.
