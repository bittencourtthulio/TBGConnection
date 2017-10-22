unit TBGConnection.View.Interfaces;

interface

uses
  TBGConnection.Model.Interfaces;

type
  iTBGConnection = interface
    ['{C5D26971-AB66-4D1F-8ADD-55D0F7EB8020}']
    function GetDriver: iDriver;
  end;

implementation

end.
