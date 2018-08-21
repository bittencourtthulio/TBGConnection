unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, IBX.IBDatabase, TBGQuery.View.Principal,
  TBGInterbaseExpressDriver.View.Driver, TBGConnection.View.Principal,
  Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    Image1: TImage;
    TBGConnection1: TTBGConnection;
    BGInterbaseExpressDriverConexao1: TBGInterbaseExpressDriverConexao;
    TBGQuery1: TTBGQuery;
    IBDatabase1: TIBDatabase;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    btnOpen: TButton;
    IBTransaction1: TIBTransaction;
    procedure btnOpenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnOpenClick(Sender: TObject);
begin
//  TBGQuery1.Query.SQL.Add('select * from clientes');
  TBGQuery1.Query.Open('select * from clientes');
end;

end.
