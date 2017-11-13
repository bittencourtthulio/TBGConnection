object IWServerController: TIWServerController
  OldCreateOrder = False
  AuthBeforeNewSession = False
  AppName = 'MyApp'
  CacheDir = 'C:\Users\thuli\AppData\Local\Temp\'
  ComInitialization = ciNone
  Compression.Enabled = True
  Compression.Level = 6
  Description = 'My IntraWeb Application'
  DebugHTML = False
  DisplayName = 'IntraWeb Application'
  Log = loNone
  EnableImageToolbar = False
  ExceptionDisplayMode = smAlert
  HistoryEnabled = False
  JavascriptDebug = False
  PageTransitions = False
  Port = 8888
  RedirectMsgDelay = 0
  ServerResizeTimeout = 0
  ShowLoadingAnimation = True
  SessionTimeout = 10
  SSLOptions.NonSSLRequest = nsAccept
  SSLOptions.Port = 0
  SSLOptions.SSLVersion = sslv3
  Version = '14.0.0'
  AllowMultipleSessionsPerUser = False
  IECompatibilityMode = 'IE=8'
  OnNewSession = IWServerControllerBaseNewSession
  Height = 407
  Width = 660
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Bancos\Firebird\BANCO1.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Left = 572
    Top = 72
  end
  object BGFiredacDriverConexao1: TBGFiredacDriverConexao
    FConnection = FDConnection1
    LimitCache = 50
    Left = 496
    Top = 72
  end
  object TBGConnection1: TTBGConnection
    Driver = BGFiredacDriverConexao1
    Left = 344
    Top = 72
  end
end
