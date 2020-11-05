object fclMain: TfclMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1050#1083#1080#1077#1085#1090
  ClientHeight = 388
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI Semibold'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 764
    Height = 57
    Align = alTop
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 27
      Height = 13
      Caption = #1061#1086#1089#1090':'
    end
    object Label1: TLabel
      Left = 218
      Top = 24
      Width = 30
      Height = 13
      Caption = #1055#1086#1088#1090':'
    end
    object ehost: TEdit
      Left = 41
      Top = 20
      Width = 163
      Height = 21
      TabOrder = 0
      Text = 'LocalHost'
    end
    object ePort: TEdit
      Left = 254
      Top = 20
      Width = 35
      Height = 21
      TabOrder = 1
      Text = '211'
    end
    object bName: TButton
      Left = 304
      Top = 18
      Width = 89
      Height = 25
      Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100
      TabOrder = 2
      OnClick = bNameClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 57
    Width = 764
    Height = 331
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 0
      Top = 32
      Width = 764
      Height = 299
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Segoe UI Semibold'
      TitleFont.Style = []
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 764
      Height = 32
      Align = alTop
      TabOrder = 1
      object bCSV: TButton
        Left = 253
        Top = 5
        Width = 139
        Height = 25
        Caption = #1042#1099#1074#1072#1083#1080#1090#1100' '#1074' CSV'
        Enabled = False
        TabOrder = 0
        OnClick = bCSVClick
      end
      object DBNavigator1: TDBNavigator
        Left = 7
        Top = 5
        Width = 240
        Height = 25
        DataSource = DataSource1
        TabOrder = 1
      end
    end
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'DataSnapCONNECTION'
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=22.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'DriverName=DataSnap'
      'Port=111111'
      'Filters={}'
      'AppName=MyTestDBApp')
    AfterConnect = SQLConnection1AfterConnect
    Left = 528
    Top = 8
  end
  object SqlServerMethod1: TSqlServerMethod
    Params = <
      item
        DataType = ftWideString
        Precision = 2000
        Name = 'sql_like'
        ParamType = ptInput
      end
      item
        DataType = ftDataSet
        Name = 'ReturnParameter'
        ParamType = ptResult
        Value = 'TDataSet'
      end>
    SQLConnection = SQLConnection1
    ServerMethodName = 'TServerMethods1.ClientGetSQLRes'
    Left = 592
    Top = 8
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = SqlServerMethod1
    Constraints = False
    Left = 656
    Top = 8
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = ClientDataSet1
    OnStateChange = DataSource1StateChange
    Left = 592
    Top = 64
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    ReadOnly = True
    Left = 528
    Top = 64
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    FileName = 'test'
    Filter = 'csv|*.csv|txt|*.txt'
    InitialDir = 'c:/'
    Left = 408
    Top = 56
  end
end
