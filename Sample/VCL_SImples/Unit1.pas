unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataModule, Data.DB, Vcl.StdCtrls,
  TBGQuery.View.Principal, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    TBGQuery1: TTBGQuery;
    Button1: TButton;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    TBGQuery2: TTBGQuery;
    DBEdit2: TDBEdit;
    Edit1: TEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  TBGQuery1.Query.Open('SELECT RUA, NOME FROM ENDERECO INNER JOIN CLIENTE ON CLIENTE.ID = ENDERECO.IDCLIENTE');
  TBGQuery1.Query.Fields.FieldByName('RUA').DisplayWidth := 50;
  TBGQuery1.Query.Fields.FieldByName('NOME').DisplayWidth := 50;

  TBGQuery2.Query.Open('SELECT * FROM CLIENTE ORDER BY ID');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TBGQuery2.Query.Open(Edit1.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TBGQuery1.Connection := DM.TBGConnection1;
  TBGQuery2.Connection := DM.TBGConnection1;
end;

end.
