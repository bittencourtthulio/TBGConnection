object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 432
  Width = 822
  object TBGConnection1: TTBGConnection
    Driver = BGFiredacDriverConexao1
    Left = 328
    Top = 176
  end
  object TBGQuery1: TTBGQuery
    Connection = TBGConnection1
    Left = 432
    Top = 176
  end
  object BGFiredacDriverConexao1: TBGFiredacDriverConexao
    FConnection = FDConnection1
    LimitCache = 50
    Left = 536
    Top = 176
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Bancos\Firebird\BANCO1.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Left = 672
    Top = 200
  end
end
