unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, TBGFirebaseConnection.View.Connection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm3 = class(TForm)
    TBGFirebaseConnection1: TTBGFirebaseConnection;
    Button1: TButton;
    FDMemTable1: TFDMemTable;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  TBGFirebaseConnection1
  .Connect
    .BaseURL('https://meuapp-e4931.firebaseio.com/')
    .Auth('Anonymous')
    .uId('76c7f3c2-f35a-4ea3-ac33-7dc3860465e1')
  .&End
  .Put
    .Resource('teste')
    .Json('{ "teste" : "teste", "numero" : 55 }')
  .&End;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  TBGFirebaseConnection1
  .Connect
    .BaseURL('https://meuapp-e4931.firebaseio.com/')
    .Auth('Anonymous')
    .uId('76c7f3c2-f35a-4ea3-ac33-7dc3860465e1')
  .&End
  .Get
    .DataSet(FDMemTable1)
    .Resource('teste')
  .&End
  .Exec;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  TBGFirebaseConnection1
  .Connect
    .BaseURL('https://meuapp-e4931.firebaseio.com/')
    .Auth('Anonymous')
    .uId('76c7f3c2-f35a-4ea3-ac33-7dc3860465e1')
  .&End
  .Patch
    .Resource('teste')
    .Json('{ "cpf" : "teste222" }')
  .&End;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  TBGFirebaseConnection1
  .Connect
    .BaseURL('https://meuapp-e4931.firebaseio.com/')
    .Auth('Anonymous')
    .uId('76c7f3c2-f35a-4ea3-ac33-7dc3860465e1')
  .&End
  .Delete
    .Resource('teste')
  .&End;
end;

end.
