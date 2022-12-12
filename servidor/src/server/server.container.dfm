object ServerContainer1: TServerContainer1
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    Left = 96
    Top = 11
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 200
    Top = 11
  end
  object FDManager1: TFDManager
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 96
    Top = 72
  end
  object FDConnection1: TFDConnection
    Left = 96
    Top = 128
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 96
    Top = 184
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 224
    Top = 184
  end
end
