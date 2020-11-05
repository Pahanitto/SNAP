object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    OnConnect = DSServer1Connect
    OnDisconnect = DSServer1Disconnect
    AutoStart = False
    Left = 96
    Top = 19
  end
  object DSTCPServerTransport1: TDSTCPServerTransport
    Server = DSServer1
    Filters = <>
    Left = 96
    Top = 89
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    Left = 200
    Top = 19
  end
end
