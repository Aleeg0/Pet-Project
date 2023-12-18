object Form1: TForm1
  Left = 0
  Top = 0
  Hint = #1057#1086#1089#1090#1072#1074#1090#1077' '#1089#1083#1086#1074#1086' '#1080#1079' '#1073#1091#1082#1074
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1069#1088#1091#1076#1080#1090
  ClientHeight = 133
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 20
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 148
    Height = 23
    Caption = #1048#1075#1088#1086#1082' N '#1074#1072#1096' '#1093#1086#1076'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 115
    Height = 20
    Caption = #1042#1072#1096' '#1085#1072#1073#1086#1088' '#1073#1091#1082#1074':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 129
    Top = 40
    Width = 99
    Height = 20
    Caption = 'QWERTYUIOPA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 66
    Width = 85
    Height = 20
    Caption = #1042#1072#1096#1077' '#1089#1083#1086#1074#1086':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 272
    Top = 40
    Width = 97
    Height = 20
    Caption = #1042#1072#1096#1080' '#1073#1086#1085#1091#1089#1099':'
  end
  object Edit1: TEdit
    Left = 129
    Top = 63
    Width = 99
    Height = 28
    Hint = #1057#1086#1089#1090#1072#1074#1090#1077' '#1089#1083#1086#1074#1086' '#1080#1079' '#1073#1091#1082#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TextHint = #1042#1072#1096#1077' '#1089#1083#1086#1074#1086
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 97
    Width = 220
    Height = 25
    Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1090#1100' '#1074#1099#1073#1086#1088
    Kind = bkAll
    NumGlyphs = 2
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 272
    Top = 66
    Width = 137
    Height = 25
    Caption = #1055#1086#1084#1086#1097#1100' '#1076#1088#1091#1075#1072
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 272
    Top = 97
    Width = 137
    Height = 25
    Caption = #1055#1086#1084#1086#1097#1100' '#1076#1088#1091#1075#1072
    Kind = bkIgnore
    NumGlyphs = 2
    TabOrder = 3
    OnClick = BitBtn3Click
  end
end
