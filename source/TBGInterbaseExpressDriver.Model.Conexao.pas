unit TBGInterbaseExpressDriver.Model.Conexao;

interface
uses
  System.Classes,
  Data.DB, IBX.IBDatabase,
  TBGConnection.Model.Interfaces,
  TBGConnection.Model.DataSet.Interfaces;

Type
  TInterbaseExpressDriverModelConexao = class(TInterfacedObject, iConexao)
    private
      FConnection : TIBDatabase;
      FTrans: TIBTransaction;
      FDriver : iDriver;
    public
      constructor Create(Connection : TIBDatabase; LimitCacheRegister : Integer; Driver : iDriver);
      destructor Destroy; override;
      class function New(Connection : TIBDatabase; LimitCacheRegister : Integer; Driver : iDriver) : iConexao;
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
  System.SysUtils, TBGConnection.Model.DataSet.Proxy;

{ TInterbaseExpressDriverModelConexao }

function TInterbaseExpressDriverModelConexao.Commit: iConexao;
begin
  Result := Self;
  FConnection.Transactions[FConnection.FindTransaction(FTrans)].CommitRetaining;
end;

function TInterbaseExpressDriverModelConexao.Conectar: iConexao;
begin
  Result := Self;
  FConnection.Connected := True;

end;

function TInterbaseExpressDriverModelConexao.Connection: TCustomConnection;
begin
  Result := FConnection;
end;

constructor TInterbaseExpressDriverModelConexao.Create(Connection: TIBDatabase;
  LimitCacheRegister: Integer; Driver: iDriver);
begin
  FConnection := Connection;
  FDriver := Driver;
end;

destructor TInterbaseExpressDriverModelConexao.Destroy;
begin

  inherited;
end;

function TInterbaseExpressDriverModelConexao.&End: TComponent;
begin
  Result := FConnection;
end;

class function TInterbaseExpressDriverModelConexao.New(Connection: TIBDatabase;
  LimitCacheRegister: Integer; Driver: iDriver): iConexao;
begin
  Result := Self.Create(Connection, LimitCacheRegister, Driver);
end;

function TInterbaseExpressDriverModelConexao.RollbackTransaction: iConexao;
begin
  Result := Self;
  FConnection.Transactions[FConnection.FindTransaction(FTrans)].RollbackRetaining;
end;

function TInterbaseExpressDriverModelConexao.StartTransaction: iConexao;
begin
  Result := Self;
  FConnection.Transactions[FConnection.FindTransaction(FTrans)].StartTransaction;
end;

end.
