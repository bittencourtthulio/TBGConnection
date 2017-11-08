program VCLSimples;

uses
  Vcl.Forms,
  Unit3 in 'Unit3.pas' {Form3},
  Vcl.Themes,
  Vcl.Styles,
  DataModule in 'DataModule.pas' {DM: TDataModule},
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  //ReportMemoryLeaksOnShutdown := true;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Silver');
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
