unit TBGFirebaseConnection.View.Connection;

interface

uses
  TBGFirebaseConnection.Interfaces, System.Classes;

Type
  TTBGFirebaseConnection = class(TComponent, iFirebaseConnection)
    private
      FConnect : iFirebaseConnect;
      FPut : iFirebasePut;
      FGet : iFirebaseGet;
      FPatch : iFirebasePatch;
    public
      constructor Create; reintroduce;
      destructor Destroy; override;
      class function New : iFirebaseConnection;
      function Connect : iFirebaseConnect;
      function Put : iFirebasePut;
      function Get : iFirebaseGet;
      function Patch : iFirebasePatch;
      procedure &Exec;
  end;

procedure Register;

implementation

uses
  TBGFirebaseConnection.Model.Connect, TBGFirebaseConnection.Model.Put,
  TBGFirebaseConnection.Model.Get, TBGFirebaseConnection.Model.Patch;

{ TTBGFirebaseConnection }

function TTBGFirebaseConnection.Connect: iFirebaseConnect;
begin
  if not Assigned(FConnect) then
    FConnect := TFirebaseConnectionMoldeConnect.New(Self);

  Result := FConnect;
end;

constructor TTBGFirebaseConnection.Create;
begin

end;

destructor TTBGFirebaseConnection.Destroy;
begin

  inherited;
end;

procedure TTBGFirebaseConnection.Exec;
begin
  //Somente para Encerrar o Ciclo;
end;

function TTBGFirebaseConnection.Get: iFirebaseGet;
begin
  if not Assigned(FGet) then
    FGet := TFirebaseConnectionModelGet.New(Self);

  Result := FGet;
end;

class function TTBGFirebaseConnection.New: iFirebaseConnection;
begin
  Result := Self.Create;
end;

function TTBGFirebaseConnection.Patch: iFirebasePatch;
begin
  if not Assigned(FPatch) then
    FPatch := TFirebaseConnectionModelPatch.New(Self);

  Result := FPatch;
end;

function TTBGFirebaseConnection.Put: iFirebasePut;
begin
  if not Assigned(FPut) then
    FPut := TFirebaseConnectionModelPut.New(Self);
  Result := FPut;
end;

procedure Register;
begin
  RegisterComponents('TBGAbstractConnection', [TTBGFirebaseConnection]);
end;


end.
