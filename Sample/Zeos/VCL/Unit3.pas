unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  TBGQuery.View.Principal, TBGConnection.View.Principal, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls, ZAbstractConnection, ZConnection,
  TBGZeosDriver.View.Driver;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    SQL: TLabel;
    DBGrid2: TDBGrid;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    TBGQuery1: TTBGQuery;
    TBGQuery2: TTBGQuery;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Button11: TButton;
    TBGQuery3: TTBGQuery;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Button12: TButton;
    TBGQuery4: TTBGQuery;
    GroupBox3: TGroupBox;
    Button13: TButton;
    Image1: TImage;
    Button14: TButton;
    Button15: TButton;
    BGZeosDriverConexao1: TBGZeosDriverConexao;
    ZConnection1: TZConnection;
    TBGConnection1: TTBGConnection;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button10Click(Sender: TObject);
begin
  TBGQuery2.Query.DataSet.Post;
end;

procedure TForm3.Button11Click(Sender: TObject);
begin
  TBGQuery3.Query.SQL.Text := 'INSERT INTO CLIENTE (ID, NOME) VALUES (:ID, :NOME)';
  TBGQuery3.Query.Params.ParamByName('ID').AsInteger := StrToInt(Edit2.Text);
  TBGQuery3.Query.Params.ParamByName('NOME').AsString := Edit3.Text;
  TBGQuery3.Query.ExecSQL;
end;

procedure TForm3.Button12Click(Sender: TObject);
begin
  TBGConnection1.Driver.Conexao.StartTransaction;
  try
    TBGQuery4.Query.SQL.Text := 'INSERT INTO CLIENTE (ID, NOME) VALUES (:ID, :NOME)';
    TBGQuery4.Query.Params.ParamByName('ID').AsInteger := StrToInt(Edit4.Text);
    TBGQuery4.Query.Params.ParamByName('NOME').AsString := Edit5.Text;
    TBGQuery4.Query.ExecSQL;
    TBGConnection1.Driver.Conexao.Commit;
  except
    TBGConnection1.Driver.Conexao.RollbackTransaction;
  end;
end;

procedure TForm3.Button13Click(Sender: TObject);
begin
  TBGConnection1.Driver.Cache.ClearCache;
end;

procedure TForm3.Button14Click(Sender: TObject);
begin
  TBGQuery1.Query.Fields.FieldByName('NOME').DisplayWidth := 40;
end;

procedure TForm3.Button15Click(Sender: TObject);
begin
  ShowMessage(TBGQuery1.Query.Fields.FieldByName('NOME').AsString);
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  TBGQuery1.Query.Open(Edit1.Text);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  TBGQuery1.Query.DataSet.Insert;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  TBGQuery1.Query.DataSet.Edit;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  TBGQuery1.Query.DataSet.Delete;
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  TBGQuery2.Query.Open(Edit1.Text);
end;

procedure TForm3.Button6Click(Sender: TObject);
begin
  TBGQuery2.Query.DataSet.Insert;
end;

procedure TForm3.Button7Click(Sender: TObject);
begin
  TBGQuery2.Query.DataSet.Edit;
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
  TBGQuery2.Query.DataSet.Delete;
end;

procedure TForm3.Button9Click(Sender: TObject);
begin
  TBGQuery1.Query.DataSet.Post;
end;

end.
