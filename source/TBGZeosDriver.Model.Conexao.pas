unit TBGZeosDriver.Model.Conexao;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes,
  ZConnection;

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
  end;

implementation

{ TZeosDriverModelConexao }

function TZeosDriverModelConexao.Conectar: iConexao;
begin
  Result := Self;
  FConnection.Connected := true;
end;

function TZeosDriverModelConexao.&End: TComponent;
begin
  Result := FConnection;
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

end.
