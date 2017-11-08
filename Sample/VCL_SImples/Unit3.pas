unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Vcl.ExtCtrls,
  Vcl.DBCtrls,  Vcl.Mask, Data.FMTBcd,
  Data.SqlExpr, Data.DBXFirebird, Datasnap.Provider, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection,  Vcl.Imaging.jpeg,
  TBGFiredacDriver.View.Driver, TBGDBExpressDriver.View.Driver,
  TBGConnection.View.Principal, TBGZeosDriver.View.Driver, TBGConnection.Model.Interfaces,
  TBGQuery.View.Principal, FireDAC.Phys.SQLiteVDataSet, DataModule, Unit1;

type
  TForm3 = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Button3: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    ComboBox1: TComboBox;
    Label3: TLabel;
    TBGQuery1: TTBGQuery;
    Button8: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure preencherDados;
    procedure SelecionaDriver;
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  //SelecionaDriver;
  TBGQuery1.Query.Close;
  TBGQuery1.Query.Open('SELECT * FROM CLIENTE ORDER BY ID');
  TBGQuery1.Query.Fields.FieldByName('NOME').DisplayWidth := 102;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  DM.TBGConnection1.Driver.Conexao.StartTransaction;
  try
    TBGQuery1.Query.Close;
    TBGQuery1.Query.SQL.Clear;
    TBGQuery1.Query.SQL.Add('INSERT INTO CLIENTE (ID, NOME) VALUES (:ID, :NOME)');
    TBGQuery1.Query.Params[0].AsInteger := StrToInt(Edit1.Text);
    TBGQuery1.Query.Params[1].AsString := Edit2.Text;
    TBGQuery1.Query.ExecSQL;
    DM.TBGConnection1.Driver.Conexao.Commit;
  except
    DM.TBGConnection1.Driver.Conexao.RollbackTransaction;
  end;

end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  ShowMessage(
      TBGQuery1
      .Query
      .DataSet
      .FieldByName('NOME')
      .AsString
  );
end;

procedure TForm3.Button4Click(Sender: TObject);
var
 i : Integer;
begin
  TBGQuery1.Query.DataSet.Insert;
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  TBGQuery1.Query.DataSet.Edit;
end;

procedure TForm3.Button6Click(Sender: TObject);
begin
  TBGQuery1.Query.DataSet.Delete;
end;

procedure TForm3.Button7Click(Sender: TObject);
begin
  preencherDados;
  TBGQuery1.Query.DataSet.Post;
end;


procedure TForm3.Button8Click(Sender: TObject);
begin
  Form1.Show;
end;

procedure TForm3.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  if DataSource1.State = dsBrowse then
  begin
    Edit1.Text := TBGQuery1.Query.Fields.FieldByName('ID').AsString;
    Edit2.Text := TBGQuery1.Query.Fields.FieldByName('NOME').AsString;
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  TBGQuery1.Connection := DM.TBGConnection1;
end;

procedure TForm3.preencherDados;
begin
  TBGQuery1.Query.DataSet.FieldByName('ID').Value := StrToInt(Edit1.Text);
  TBGQuery1.Query.DataSet.FieldByName('NOME').Value := Edit2.Text;
end;

procedure TForm3.SelecionaDriver;
begin
  case ComboBox1.ItemIndex of
    0 : DM.TBGConnection1.Driver := DM.BGDBExpressDriverConexao1;
    1 : DM.TBGConnection1.Driver := DM.BGFiredacDriverConexao1;
    2 : DM.TBGConnection1.Driver := DM.BGZeosDriverConexao1;
    3 : DM.TBGConnection1.Driver := DM.BGUnidacDriverConexao1;
  end;
end;

end.
