object fMemoWin: TfMemoWin
  Left = 0
  Top = 0
  Caption = #1058#1077#1082#1089#1090
  ClientHeight = 402
  ClientWidth = 749
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI Semibold'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object mText: TMemo
    Left = 0
    Top = 0
    Width = 749
    Height = 402
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 680
    Top = 16
    object N1: TMenuItem
      Caption = #1060#1072#1080#1083
      object N2: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
        OnClick = N3Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'txt|*.txt'
    Left = 600
    Top = 16
  end
end
