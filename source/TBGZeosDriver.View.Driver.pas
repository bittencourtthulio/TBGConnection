unit TBGZeosDriver.View.Driver;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes, TBGConnection.Model.Conexao.Parametros,
  System.Generics.Collections, ZConnection, ZDataSet;

Type
  TBGZeosDriverConexao = class(TComponent, iDriver)
  private
    FFConnection: TZConnection;
    FFQuery: TZQuery;
    FiConexao : iConexao;
    FiQuery : TList<iQuery>;
    FLimitCacheRegister : Integer;
    FLimitCache: Integer;
    procedure SetFConnection(const Value: TZConnection);
    procedure SetFQuery(const Value: TZQuery);
    procedure SetLimitCache(const Value: Integer);
    function GetLimitCache: Integer;
    protected
      FParametros : iConexaoParametros;
      function Conexao : iConexao;
      function Query : iQuery;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDriver;
      function Conectar : iConexao;
      function &End: TComponent;
      function Parametros: iConexaoParametros;
      function LimitCacheRegister(Value : Integer) : iDriver;
    published
      property FConnection : TZConnection read FFConnection write SetFConnection;
      property LimitCache : Integer read GetLimitCache write SetLimitCache;
  end;

procedure Register;

implementation

uses
  System.SysUtils, TBGZeosDriver.Model.Conexao, TBGZeosDriver.Model.Query;

{ TBGZeosDriverConexao }

function TBGZeosDriverConexao.Conectar: iConexao;
begin

end;

function TBGZeosDriverConexao.&End: TComponent;
begin

end;

function TBGZeosDriverConexao.GetLimitCache: Integer;
begin
  Result := FLimitCacheRegister;
end;

function TBGZeosDriverConexao.LimitCacheRegister(Value: Integer): iDriver;
begin
  Result := Self;
  FLimitCacheRegister := Value;
end;

function TBGZeosDriverConexao.Conexao: iConexao;
begin
  if not Assigned(FiConexao) then
    FiConexao := TZeosDriverModelConexao.New(FFConnection, FLimitCacheRegister);

  Result := FiConexao;
end;

constructor TBGZeosDriverConexao.Create;
begin
  FiQuery := TList<iQuery>.Create;
  LimitCache := 10;
end;

destructor TBGZeosDriverConexao.Destroy;
begin
  FreeAndNil(FiQuery);
  inherited;
end;

class function TBGZeosDriverConexao.New: iDriver;
begin
  Result := Self.Create;
end;

function TBGZeosDriverConexao.Parametros: iConexaoParametros;
begin
  Result := FParametros;
end;


function TBGZeosDriverConexao.Query: iQuery;
begin
  if Not Assigned(FiQuery) then
    FiQuery := TList<iQuery>.Create;

  if Not Assigned(FiConexao) then
    FiConexao := TZeosDriverModelConexao.New(FFConnection, FLimitCacheRegister);

  FiQuery.Add(TZeosModelQuery.New(FFConnection, FiConexao));
  Result := FiQuery[FiQuery.Count-1];
end;

procedure TBGZeosDriverConexao.SetFConnection(const Value: TZConnection);
begin
  FFConnection := Value;
end;

procedure TBGZeosDriverConexao.SetFQuery(const Value: TZQuery);
begin
  FFQuery := Value;
end;

procedure TBGZeosDriverConexao.SetLimitCache(const Value: Integer);
begin
  FLimitCacheRegister := Value;
end;

procedure Register;
begin
  RegisterComponents('TBGAbstractConnection', [TBGZeosDriverConexao]);
end;

end.
