object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 299
  Width = 499
  object MssqlCon: TSQLConnection
    Tag = 100
    DriverName = 'MSSQL'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=MSSQL'
      'SchemaOverride=%.dbo'
      'DriverUnit=Data.DBXMSSQL'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver220.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=22.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXMsSqlMetaDataCommandFactory,DbxMSSQLDr' +
        'iver220.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXMsSqlMetaDataCommandFact' +
        'ory,Borland.Data.DbxMSSQLDriver,Version=22.0.0.0,Culture=neutral' +
        ',PublicKeyToken=91d62ebb5b0d1b1b'
      'LibraryName=dbxmss.dll'
      'VendorLib=sqlncli10.dll'
      'VendorLibWin64=sqlncli10.dll'
      'HostName=ServerName'
      'DataBase=Database Name'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'OSAuthentication=False'
      'PrepareSQL=True'
      'User_Name=user'
      'Password=password'
      'BlobSize=-1'
      'ErrorResourceFile='
      'OS Authentication=False'
      'Prepare SQL=False')
    BeforeConnect = MssqlConBeforeConnect
    Left = 56
    Top = 38
  end
  object dsTest_tab: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = MssqlCon
    Left = 120
    Top = 32
  end
end
