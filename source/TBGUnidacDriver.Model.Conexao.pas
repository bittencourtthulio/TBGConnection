unit TBGUnidacDriver.Model.Conexao;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes, Data.DB, MemDS, DBAccess, Uni,
  TBGConnection.Model.DataSet.Interfaces;

Type
  TUnidacDriverModelConexao = class(TInterfacedObject, iConexao)
    private
      FConnection : TUniConnection;
      FDriver : iDriver;
    public
      constructor Create(Connection : TUniConnection; LimitCacheRegister : Integer; Driver : iDriver);
      destructor Destroy; override;
      class function New(Connection : TUniConnection; LimitCacheRegister : Integer; Driver : iDriver) : iConexao;
      //iConexao
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

constructor TUnidacDriverModelConexao.Create(Connection : TUniConnection; LimitCacheRegister : Integer; Driver : iDriver);
begin
  FConnection := Connection;
  FDriver := Driver;
end;

destructor TUnidacDriverModelConexao.Destroy;
begin

  inherited;
end;

class function TUnidacDriverModelConexao.New(Connection : TUniConnection; LimitCacheRegister : Integer; Driver : iDriver) : iConexao;
begin
  Result := Self.Create(Connection, LimitCacheRegister, Driver);
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
