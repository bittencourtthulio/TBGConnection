unit TBGConnection.Model.Helper;

interface

type

  THelperString = record helper for String
    function ToExtractTableName : String;
  end;

implementation

uses
  System.SysUtils;

{ THelperString }

function THelperString.ToExtractTableName: String;
var
  Aux : String;
begin
  if Pos('INSERT', Self) > 0 then
     Aux := Trim(Copy(Self, Pos('INTO ', Self) + 5, Length(Self)));

  if (Pos('SELECT', Self) > 0) or (Pos('DELETE', Self) > 0)  then
    Aux := Trim(Copy(Self, Pos('FROM ', Self) + 5, Length(Self)));

  if (Pos('UPDATE', Self) > 0) then
    Aux := Trim(Copy(Self, Pos('UPDATE ', Self) + 7, Length(Self)));

  Result := Copy(Aux, 1, (Length(Aux) - (Length(Aux) - Pos(' ', Aux))));
end;

end.
