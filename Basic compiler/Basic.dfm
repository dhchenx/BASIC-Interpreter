object Form43: TForm43
  Left = 0
  Top = 0
  Width = 504
  Height = 513
  Caption = 'Basic Interpreter'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  DesignSize = (
    496
    459)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 384
    Width = 41
    Height = 18
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object RichEdit1: TRichEdit
    Left = 8
    Top = 8
    Width = 249
    Height = 225
    Anchors = []
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    Lines.Strings = (
      '')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    OnKeyDown = RichEdit1KeyDown
    OnMouseDown = RichEdit1MouseDown
  end
  object Memo1: TMemo
    Left = 8
    Top = 240
    Width = 249
    Height = 97
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button1: TButton
    Left = 400
    Top = 424
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
  end
  object Memo2: TMemo
    Left = 256
    Top = 8
    Width = 225
    Height = 225
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    Lines.Strings = (
      'Memo2')
    TabOrder = 3
  end
  object Button2: TButton
    Left = 368
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 4
    OnClick = Button2Click
  end
  object XPManifest1: TXPManifest
    Left = 320
    Top = 408
  end
  object MainMenu1: TMainMenu
    Left = 160
    Top = 176
    object FileF1: TMenuItem
      Caption = 'File(&F)'
      object NewN1: TMenuItem
        Caption = 'New(&N)'
      end
      object OpenO1: TMenuItem
        Caption = 'Open(&O)'
      end
      object SaveS1: TMenuItem
        Caption = 'Save(&S)'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object ExitE1: TMenuItem
        Caption = 'Exit(&E)'
      end
    end
    object EditE1: TMenuItem
      Caption = 'Edit(&E)'
      object Undo1: TMenuItem
        Caption = 'Undo(&U)'
      end
      object RedoR1: TMenuItem
        Caption = 'Redo(&R)'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object AllClearC1: TMenuItem
        Caption = 'All Clear(&C)'
      end
    end
    object Debug1: TMenuItem
      Caption = 'Debug(&D)'
      object RunR1: TMenuItem
        Caption = 'Run(&R)'
        OnClick = RunR1Click
      end
      object CompileToBasic1: TMenuItem
        Caption = 'CompileToBasicDirection(&C)'
      end
    end
    object HelpH1: TMenuItem
      Caption = 'Help(&H)'
      object AboutA1: TMenuItem
        Caption = 'About(&A)'
      end
    end
  end
end
