unit TBGZeosDriver.Model.Conexao;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes,
  ZConnection, Data.DB, TBGConnection.Model.DataSet.Interfaces;

Type
  TZeosDriverModelConexao = class(TInterfacedObject, iConexao)
    private
      FConnection : TZConnection;
      FCache : iDriverProxy;
    public
      constructor Create(Connection : TZConnection; LimitCacheRegister : Integer);
      destructor Destroy; override;
      class function New(Connection : TZConnection; LimitCacheRegister : Integer) : iConexao;
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
  System.SysUtils, TBGConnection.Model.DataSet.Proxy;

{ TZeosDriverModelConexao }

function TZeosDriverModelConexao.Cache: iDriverProxy;
begin
  Result := FCache;
end;

function TZeosDriverModelConexao.Commit: iConexao;
begin
  Result := Self;
  FConnection.Commit;
end;

function TZeosDriverModelConexao.Conectar: iConexao;
begin
  Result := Self;
  FConnection.Connected := true;
end;

function TZeosDriverModelConexao.&End: TComponent;
begin
  Result := FConnection;
end;

function TZeosDriverModelConexao.Connection: TCustomConnection;
begin
  raise Exception.Create('Função não suportada para este driver');
end;

constructor TZeosDriverModelConexao.Create(Connection : TZConnection; LimitCacheRegister : Integer);
begin
  FConnection := Connection;
  FCache := TTBGConnectionModelProxy.New(LimitCacheRegister);
end;

destructor TZeosDriverModelConexao.Destroy;
begin

  inherited;
end;

class function TZeosDriverModelConexao.New(Connection : TZConnection; LimitCacheRegister : Integer) : iConexao;
begin
  Result := Self.Create(Connection, LimitCacheRegister);
end;

function TZeosDriverModelConexao.RollbackTransaction: iConexao;
begin
  Result := Self;
  FConnection.Rollback;
end;

function TZeosDriverModelConexao.StartTransaction: iConexao;
begin
  Result := Self;
  FConnection.StartTransaction;
end;

end.

