unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  TBGQuery.View.Principal, TBGConnection.View.Principal, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, InterBaseUniProvider, DBAccess,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls, uRESTDWPoolerDB,
  TBGRestDWDriver.View.Driver, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  TBGFiredacDriver.View.Driver, uDWAbout;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    SQL: TLabel;
    DBGrid2: TDBGrid;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
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
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Button12: TButton;
    GroupBox3: TGroupBox;
    Button13: TButton;
    Image1: TImage;
    Button14: TButton;
    Button15: TButton;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    eHost: TEdit;
    ePort: TEdit;
    edPasswordDW: TEdit;
    edUserNameDW: TEdit;
    CheckBox1: TCheckBox;
    Button16: TButton;
    RESTDWDataBase1: TRESTDWDataBase;
    Button17: TButton;
    BGRestDWDriverConexao1: TBGRestDWDriverConexao;
    TBGConnection1: TTBGConnection;
    TBGQuery1: TTBGQuery;
    TBGQuery2: TTBGQuery;
    TBGQuery3: TTBGQuery;
    TBGQuery4: TTBGQuery;
    BGFiredacDriverConexao1: TBGFiredacDriverConexao;
    FDConnection1: TFDConnection;
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
    procedure Button16Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button17Click(Sender: TObject);
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
  TBGQuery3.Query.ParamByName('ID').AsInteger := StrToInt(Edit2.Text);
  TBGQuery3.Query.ParamByName('NOME').AsString := Edit3.Text;
  TBGQuery3.Query.ExecSQL;
end;

procedure TForm3.Button12Click(Sender: TObject);
begin
    TBGQuery4.Query.SQL.Text := 'INSERT INTO CLIENTE (ID, NOME) VALUES (:ID, :NOME)';
    TBGQuery4.Query.ParamByName('ID').AsInteger := StrToInt(Edit4.Text);
    TBGQuery4.Query.ParamByName('NOME').AsString := Edit5.Text;
    TBGQuery4.Query.ExecSQL;
end;

procedure TForm3.Button13Click(Sender: TObject);
begin
  TBGConnection1.Driver.Cache.ClearCache;
end;

procedure TForm3.Button14Click(Sender: TObject);
begin
  TBGQuery1.Query.Fields.FieldByName('NOME').DisplayWidth := 10;
  SHOWMESSAGE(TBGQuery1.Query.Fields.FieldByName('ID').AsString);
end;

procedure TForm3.Button15Click(Sender: TObject);
begin
  ShowMessage(TBGQuery1.Query.Fields.FieldByName('NOME').AsString);
  ShowMessage(TBGQuery2.Query.Fields.FieldByName('ID').AsString);
end;

procedure TForm3.Button16Click(Sender: TObject);
begin
 RESTDWDataBase1.Close;
 RESTDWDataBase1.PoolerService := EHost.Text;
 RESTDWDataBase1.PoolerPort    := StrToInt(EPort.Text);
 RESTDWDataBase1.Login         := EdUserNameDW.Text;
 RESTDWDataBase1.Password      := EdPasswordDW.Text;
 RESTDWDataBase1.Compression   := CheckBox1.Checked;
 RESTDWDataBase1.Open;
end;

procedure TForm3.Button17Click(Sender: TObject);
begin
  TBGQuery2.Query.Fields.FieldByName('NOME').DisplayWidth := 10;
  SHOWMESSAGE(TBGQuery2.Query.Fields.FieldByName('ID').AsString);
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  TBGQuery1.Query.Open(Edit1.Text);
  TBGQuery1.Query.Fields.Fieldbyname('ID').ProviderFlags := [pfInUpdate, pfInWhere, pfInKey];
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
  TBGQuery2.Query.Fields.FieldByName('ID').ProviderFlags := [pfInUpdate, pfInWhere, pfInKey];
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

procedure TForm3.FormCreate(Sender: TObject);
begin
   TBGQuery1.Query.UpdateTableName('CLIENTE');
   TBGQuery2.Query.UpdateTableName('CLIENTE');
end;

end.
