unit TBGConnection.Model.DataSet.Interfaces;

interface

uses
  Data.DB;

type
  ICacheDataSetSubject = interface;

  iDataSet = interface
    ['{E90FC360-74B8-4D5C-9418-F517DFF564A4}']
    function DataSet : TDataSet; overload;
    function DataSet (Value : TDataSet) : iDataSet; overload;
    function GUUID : String;
    function SQL : String; overload;
    function SQL (Value : String) : iDataSet; overload;
  end;

  iDriverProxy = interface
    ['{7EA13C01-D9FA-464F-AD0D-364365168D39}']
    function CacheDataSet(Key : String; var Value : iDataSet) : boolean;
    function AddCacheDataSet(Key : String; Value : iDataSet) : iDriverProxy;
    function RemoveCache(Key : String) : iDriverProxy;
    function ClearCache : iDriverProxy;
    function ReloadCache(Value : String) : iDriverProxy;
    function ObserverList : ICacheDataSetSubject;
  end;

  ICacheDataSetObserver = interface
    ['{13C186CF-11B0-44E3-B202-E755F7FD5500}']
    function Update(Value : String) : ICacheDataSetObserver;
  end;

  ICacheDataSetSubject = interface
    ['{2065188E-47F8-431A-9AE7-20E0915E89B3}']
    function AddObserver(Value : ICacheDataSetObserver) : ICacheDataSetSubject;
    function RemoveObserver(Value : ICacheDataSetObserver) : ICacheDataSetSubject;
    function Notify(Value : String) : ICacheDataSetSubject;
  end;

  iDataSetFactory = interface
    ['{E884A6C6-6C80-4953-A52C-2AD0A4D157DB}']
    function DataSet(Observer : ICacheDataSetSubject) : iDataSet;
  end;

implementation

end.

