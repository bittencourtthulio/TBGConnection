unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DBXFirebird, ZAbstractConnection,
  ZConnection, TBGZeosDriver.View.Driver, TBGDBExpressDriver.View.Driver,
  Data.SqlExpr, Data.DB, FireDAC.Comp.Client, TBGFiredacDriver.View.Driver,
  TBGConnection.View.Principal, TBGUnidacDriver.View.Driver, UniProvider,
  InterBaseUniProvider, DBAccess, Uni;

type
  TDM = class(TDataModule)
    TBGConnection1: TTBGConnection;
    BGFiredacDriverConexao1: TBGFiredacDriverConexao;
    FDConnection1: TFDConnection;
    SQLConnection1: TSQLConnection;
    BGDBExpressDriverConexao1: TBGDBExpressDriverConexao;
    BGZeosDriverConexao1: TBGZeosDriverConexao;
    ZConnection1: TZConnection;
    UniConnection1: TUniConnection;
    InterBaseUniProvider1: TInterBaseUniProvider;
    BGUnidacDriverConexao1: TBGUnidacDriverConexao;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
