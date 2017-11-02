unit TBGUnidacDriver.Model.Conexao;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes, Data.DB, MemDS, DBAccess, Uni;

Type
  TUnidacDriverModelConexao = class(TInterfacedObject, iConexao)
    private
      FConnection : TUniConnection;
    public
      constructor Create(Connection : TUniConnection);
      destructor Destroy; override;
      class function New(Connection : TUniConnection) : iConexao;
      //iConexao
      function Conectar : iConexao;
      function &End: TComponent;
      function Connection : TCustomConnection;
      function StartTransaction : iConexao;
      function RollbackTransaction : iConexao;
      function Commit : iConexao;
  end;

implementation

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

constructor TUnidacDriverModelConexao.Create(Connection : TUniConnection);
begin
  FConnection := Connection;
end;

destructor TUnidacDriverModelConexao.Destroy;
begin

  inherited;
end;

class function TUnidacDriverModelConexao.New(Connection : TUniConnection) : iConexao;
begin
  Result := Self.Create(Connection);
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
