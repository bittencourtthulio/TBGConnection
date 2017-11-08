object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 566
  ClientWidth = 728
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
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 712
    Height = 169
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 8
    Top = 520
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 1
    OnClick = Button1Click
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 200
    Width = 712
    Height = 145
    DataSource = DataSource2
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBEdit2: TDBEdit
    Left = 64
    Top = 400
    Width = 601
    Height = 21
    DataField = 'NOME'
    DataSource = DataSource2
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 80
    Top = 448
    Width = 585
    Height = 21
    TabOrder = 4
    Text = 'Edit1'
  end
  object Button2: TButton
    Left = 590
    Top = 475
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 5
    OnClick = Button2Click
  end
  object DataSource1: TDataSource
    Left = 80
    Top = 144
  end
  object TBGQuery1: TTBGQuery
    DataSource = DataSource1
    Left = 184
    Top = 144
  end
  object DataSource2: TDataSource
    Left = 112
    Top = 288
  end
  object TBGQuery2: TTBGQuery
    DataSource = DataSource2
    Left = 216
    Top = 280
  end
end
