unit TBGZeosDriver.Model.Conexao;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes,
  ZConnection, Data.DB;

Type
  TZeosDriverModelConexao = class(TInterfacedObject, iConexao)
    private
      FConnection : TZConnection;
    public
      constructor Create(Connection : TZConnection);
      destructor Destroy; override;
      class function New(Connection : TZConnection) : iConexao;
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
  System.SysUtils;

{ TZeosDriverModelConexao }

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

constructor TZeosDriverModelConexao.Create(Connection : TZConnection);
begin
  FConnection := Connection;
end;

destructor TZeosDriverModelConexao.Destroy;
begin

  inherited;
end;

class function TZeosDriverModelConexao.New(Connection : TZConnection) : iConexao;
begin
  Result := Self.Create(Connection);
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
