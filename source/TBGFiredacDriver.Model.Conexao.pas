unit TBGFiredacDriver.Model.Conexao;

interface

uses
  TBGConnection.Model.Interfaces, FireDAC.Comp.Client, System.Classes, Data.DB,
  TBGConnection.Model.DataSet.Interfaces;

Type
  TFiredacDriverModelConexao = class(TInterfacedObject, iConexao)
    private
      FConnection : TFDConnection;
      FDriver : iDriver;
    public
      constructor Create(Connection : TFDConnection; LimitCacheRegister : Integer; Driver : iDriver);
      destructor Destroy; override;
      class function New(Connection : TFDConnection; LimitCacheRegister : Integer; Driver : iDriver) : iConexao;
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

{ TFiredacDriverModelConexao }

function TFiredacDriverModelConexao.Commit: iConexao;
begin
  Result := Self;
  FConnection.Commit;
end;

function TFiredacDriverModelConexao.Conectar: iConexao;
begin
  Result := Self;
  FConnection.Connected := true;
end;

function TFiredacDriverModelConexao.&End: TComponent;
begin
  Result := FConnection;
end;

function TFiredacDriverModelConexao.Connection: TCustomConnection;
begin
  Result := FConnection;
end;

constructor TFiredacDriverModelConexao.Create(Connection : TFDConnection; LimitCacheRegister : Integer; Driver : iDriver);
begin
  FConnection := Connection;
  FDriver := Driver;
end;

destructor TFiredacDriverModelConexao.Destroy;
begin

  inherited;
end;

class function TFiredacDriverModelConexao.New(Connection : TFDConnection; LimitCacheRegister : Integer; Driver : iDriver) : iConexao;
begin
  Result := Self.Create(Connection, LimitCacheRegister, Driver);
end;

function TFiredacDriverModelConexao.RollbackTransaction: iConexao;
begin
  Result := Self;
  FConnection.Rollback;
end;

function TFiredacDriverModelConexao.StartTransaction: iConexao;
begin
  Result := Self;
  FConnection.StartTransaction;
end;

end.
