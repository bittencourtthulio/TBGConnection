unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  TBGFiredacDriver.View.Driver, TBGQuery.View.Principal,
  TBGConnection.View.Principal;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
    TBGConnection1: TTBGConnection;
    TBGQuery1: TTBGQuery;
    BGFiredacDriverConexao1: TBGFiredacDriverConexao;
    FDConnection1: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function Clientes : string;
  end;
{$METHODINFO OFF}

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.Clientes: string;
begin
  Result := 'teste';
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

