unit TBGConnection.Model.Conexao.Parametros;

interface

uses
  TBGConnection.Model.Interfaces;

Type
  TModelConexaoParametros = class(TInterfacedObject, iConexaoParametros)
  private
    FConexao: iConexao;
    FDatabase : String;
    FUserName : String;
    FPassword : String;
    FDriverID : String;
    FServer : String;
    FPorta : Integer;
  public
    constructor Create(Conexao: iConexao);
    destructor Destroy; override;
    class function New(Conexao: iConexao): iConexaoParametros;
    function Database(Value: String): iConexaoParametros;
    function UserName(Value: String): iConexaoParametros;
    function Password(Value: String): iConexaoParametros;
    function DriverID(Value: String): iConexaoParametros;
    function Server(Value: String): iConexaoParametros;
    function Porta(Value: Integer): iConexaoParametros;
    function GetDatabase(Value: String): String;
    function GetUserName(Value: String): String;
    function GetPassword(Value: String): String;
    function GetDriverID(Value: String): String;
    function GetServer(Value: String): String;
    function GetPorta(Value: Integer): Integer;
    function &End: iConexao;
  end;

implementation

{ TModelConexaoParametros }

function TModelConexaoParametros.&End: iConexao;
begin
  Result := FConexao;
end;

constructor TModelConexaoParametros.Create(Conexao: iConexao);
begin
  FConexao := Conexao;
end;

function TModelConexaoParametros.Database(Value: String): iConexaoParametros;
begin
  Result := Self;
  FDatabase := Value;
end;

destructor TModelConexaoParametros.Destroy;
begin

  inherited;
end;

function TModelConexaoParametros.DriverID(Value: String): iConexaoParametros;
begin
  Result := Self;
  FDriverID := Value;
end;

function TModelConexaoParametros.GetDatabase(Value: String): String;
begin
  Result := FDatabase;
end;

function TModelConexaoParametros.GetDriverID(Value: String): String;
begin
  Result := FDriverID;
end;

function TModelConexaoParametros.GetPassword(Value: String): String;
begin
  Result := FPassword;
end;

function TModelConexaoParametros.GetPorta(Value: Integer): Integer;
begin
  Result := FPorta;
end;

function TModelConexaoParametros.GetServer(Value: String): String;
begin
  Result := FServer;
end;

function TModelConexaoParametros.GetUserName(Value: String): String;
begin
  Result := FUserName;
end;

class function TModelConexaoParametros.New(Conexao: iConexao)
  : iConexaoParametros;
begin
  Result := Self.Create(Conexao);
end;

function TModelConexaoParametros.Password(Value: String): iConexaoParametros;
begin
  Result := Self;
  FPassword := Value;
end;

function TModelConexaoParametros.Porta(Value: Integer): iConexaoParametros;
begin
  Result := Self;
  FPorta := Value;
end;

function TModelConexaoParametros.Server(Value: String): iConexaoParametros;
begin
  Result := Self;
  FServer := Value;
end;

function TModelConexaoParametros.UserName(Value: String): iConexaoParametros;
begin
  Result := Self;
  FUserName := Value;
end;

end.
