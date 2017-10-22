unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  TBGConnection.View.Principal, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, TBGFiredacDriver.Model.Conexao,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, TBGFiredacDriver.View.Driver, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Vcl.ExtCtrls,
  Vcl.DBCtrls,  TBGConnection.Model.Interfaces, Vcl.Mask, Data.FMTBcd,
  Data.SqlExpr, Data.DBXFirebird, TBGDBExpressDriver.View.Driver,
  Datasnap.Provider, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, TBGZeosDriver.View.Driver;

type
  TForm3 = class(TForm)
    Button1: TButton;
    FDConnection1: TFDConnection;
    BGFiredacDriverConexao1: TBGFiredacDriverConexao;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Button3: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    TesteConnection: TSQLConnection;
    BGDBExpressDriverConexao1: TBGDBExpressDriverConexao;
    TBGConnection1: TTBGConnection;
    DBGrid1: TDBGrid;
    ZConnection1: TZConnection;
    BGZeosDriverConexao1: TBGZeosDriverConexao;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FQuery : iQuery;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  FQuery
    .DataSource(DataSource1)
    .Open('SELECT * FROM NF');
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  FQuery.ExecSQL('INSERT INTO TESTE (ID) VALUES (1)');
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  ShowMessage(
      FQuery
      .Fields
      .FieldByName('DATA_EMISSAO')
      .AsString
  );
end;

procedure TForm3.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  Edit1.Text := FQuery.Fields.FieldByName('DATA_EMISSAO').AsString;
  Edit2.Text := FQuery.Fields.FieldByName('USUARIO_INCLUSAO_DES').AsString;
  Edit3.Text := FQuery.Fields.FieldByName('HORA_EMISSAO').AsString;
  Edit4.Text := FQuery.Fields.FieldByName('HORA_SAIDA').AsString;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  FQuery := TBGConnection1.Driver.Query;
end;

end.
