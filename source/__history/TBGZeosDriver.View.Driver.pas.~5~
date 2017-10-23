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
    procedure SetFConnection(const Value: TZConnection);
    procedure SetFQuery(const Value: TZQuery);
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

    published
      property FConnection : TZConnection read FFConnection write SetFConnection;
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

function TBGZeosDriverConexao.Conexao: iConexao;
begin
  FiConexao := TZeosDriverModelConexao.New(FFConnection);
  Result := FiConexao;
end;

constructor TBGZeosDriverConexao.Create;
begin
  FiQuery := TList<iQuery>.Create;
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

  FiQuery.Add(TZeosModelQuery.New(FFConnection));
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

procedure Register;
begin
  RegisterComponents('TBGConnection', [TBGZeosDriverConexao]);
end;


end.
