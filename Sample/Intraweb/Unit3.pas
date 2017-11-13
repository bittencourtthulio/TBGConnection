unit Unit3;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  IWCompButton, IWCompEdit, TBGQuery.View.Principal,
  TBGFiredacDriver.View.Driver, TBGConnection.View.Principal, Data.DB,
  FireDAC.Comp.Client, IWDBStdCtrls, Vcl.Controls, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids,
  ServerController;

type
  TIWForm3 = class(TIWAppForm)
    IWDBGrid1: TIWDBGrid;
    IWDBNavigator1: TIWDBNavigator;
    DataSource1: TDataSource;
    TBGQuery1: TTBGQuery;
    IWEdit1: TIWEdit;
    IWButton1: TIWButton;
    IWDBEdit1: TIWDBEdit;
    IWDBEdit2: TIWDBEdit;
    procedure IWButton1Click(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}


procedure TIWForm3.IWButton1Click(Sender: TObject);
begin
  TBGQuery1.Query.Open(IWEdit1.Text);
end;

initialization
  TIWForm3.SetAsMainForm;

end.
