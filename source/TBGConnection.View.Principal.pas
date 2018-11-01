unit TBGConnection.View.Principal;

interface

uses
  TBGConnection.View.Interfaces, TBGConnection.Model.Interfaces,
  System.Classes, TBGConnection.Model.DataSet.Interfaces,
  TBGConnection.Model.DataSet.Observer;

Type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidAndroid)]
  TTBGConnection = class(TComponent, iTBGConnection)
    private
    FObserver : TConnectionModelDataSetObserver;
    FDriver: iDriver;
    procedure SetDriver(const Value: iDriver);
    function GetDriver: iDriver;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iTBGConnection;
    published
      property Driver : iDriver read GetDriver write SetDriver;
  end;

procedure Register;

implementation

uses
  TBGConnection.Model.DataSet.Proxy, System.SysUtils;

{$R Icones.dcr}

{ TTBGConnection }

constructor TTBGConnection.Create;
begin

end;

destructor TTBGConnection.Destroy;
begin

  inherited;
end;


function TTBGConnection.GetDriver: iDriver;
begin
  Result := FDriver;
end;

class function TTBGConnection.New: iTBGConnection;
begin
  Result := Self.Create;
end;


procedure TTBGConnection.SetDriver(const Value: iDriver);
begin
  FDriver := Value;
end;

procedure Register;
begin
  RegisterComponents('TBGAbstractConnection', [TTBGConnection]);
end;

initialization
  TTBGConnection.Create;

end.
