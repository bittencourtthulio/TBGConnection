object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 657
  ClientWidth = 1095
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 56
    Width = 130
    Height = 25
    Caption = 'Open'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBNavigator1: TDBNavigator
    Left = 147
    Top = 610
    Width = 940
    Height = 39
    DataSource = DataSource1
    TabOrder = 1
  end
  object Button3: TButton
    Left = 8
    Top = 118
    Width = 130
    Height = 25
    Caption = 'FieldByName'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button2: TButton
    Left = 8
    Top = 87
    Width = 130
    Height = 25
    Caption = 'ExecSQL'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 147
    Top = 16
    Width = 86
    Height = 21
    TabOrder = 4
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 459
    Top = 16
    Width = 409
    Height = 21
    TabOrder = 5
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 239
    Top = 16
    Width = 87
    Height = 21
    TabOrder = 6
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 332
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 7
    Text = 'Edit4'
  end
  object DBGrid1: TDBGrid
    Left = 147
    Top = 56
    Width = 943
    Height = 548
    DataSource = DataSource1
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Bancos\Firebird\DIVERSOS.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Left = 712
    Top = 184
  end
  object BGFiredacDriverConexao1: TBGFiredacDriverConexao
    FConnection = FDConnection1
    Left = 584
    Top = 184
  end
  object DataSource1: TDataSource
    OnDataChange = DataSource1DataChange
    Left = 168
    Top = 376
  end
  object TesteConnection: TSQLConnection
    ConnectionName = 'Teste'
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'DriverUnit=Data.DBXFirebird'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver250.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFire' +
        'birdDriver250.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandF' +
        'actory,Borland.Data.DbxFirebirdDriver,Version=24.0.0.0,Culture=n' +
        'eutral,PublicKeyToken=91d62ebb5b0d1b1b'
      'LibraryName=dbxfb.dll'
      'LibraryNameOsx=libsqlfb.dylib'
      'VendorLib=fbclient.dll'
      'VendorLibWin64=fbclient.dll'
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird'
      'Database=D:\Bancos\Firebird\DIVERSOS.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Role=RoleName'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'SQLDialect=3'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'TrimChar=False'
      'BlobSize=-1'
      'ErrorResourceFile='
      'RoleName=RoleName'
      'ServerCharSet='
      'Trim Char=False')
    Left = 720
    Top = 254
  end
  object BGDBExpressDriverConexao1: TBGDBExpressDriverConexao
    FConnection = TesteConnection
    Left = 584
    Top = 256
  end
  object TBGConnection1: TTBGConnection
    Driver = BGFiredacDriverConexao1
    Left = 424
    Top = 256
  end
  object ZConnection1: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    HostName = 'localhost'
    Port = 3050
    Database = 'D:\Bancos\Firebird\DIVERSOS.FDB'
    User = 'SYSDBA'
    Password = 'masterkey'
    Protocol = 'firebirdd-2.5'
    Left = 720
    Top = 336
  end
  object BGZeosDriverConexao1: TBGZeosDriverConexao
    FConnection = ZConnection1
    Left = 584
    Top = 336
  end
end
