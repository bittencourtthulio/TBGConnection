unit TBGDBExpressDriver.Model.Conexao;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes,
  Data.SqlExpr, Data.DB;

Type
  TDBExpressDriverModelConexao = class(TInterfacedObject, iConexao)
    private
      FConnection : TSQLConnection;
    public
      constructor Create(Connection : TSQLConnection);
      destructor Destroy; override;
      class function New(Connection : TSQLConnection) : iConexao;
      //iConexao
      function Conectar : iConexao;
      function &End: TComponent;
      function Connection : TCustomConnection;
  end;

implementation

{ TDBExpressDriverModelConexao }

function TDBExpressDriverModelConexao.Conectar: iConexao;
begin
  Result := Self;
  FConnection.Connected := true;
end;

function TDBExpressDriverModelConexao.&End: TComponent;
begin
  Result := FConnection;
end;

function TDBExpressDriverModelConexao.Connection: TCustomConnection;
begin
  Result := FConnection;
end;

constructor TDBExpressDriverModelConexao.Create(Connection : TSQLConnection);
begin
  FConnection := Connection;
end;

destructor TDBExpressDriverModelConexao.Destroy;
begin

  inherited;
end;

class function TDBExpressDriverModelConexao.New(Connection : TSQLConnection) : iConexao;
begin
  Result := Self.Create(Connection);
end;

end.
