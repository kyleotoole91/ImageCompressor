object FrmShellScript: TFrmShellScript
  Left = 0
  Top = 0
  Caption = 'Deployment Script (.bat)'
  ClientHeight = 343
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 302
    Width = 660
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 407
      Top = 0
      Width = 253
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnOK: TButton
        Left = 91
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Save'
        TabOrder = 0
        OnClick = btnOKClick
      end
      object Button2: TButton
        Left = 172
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Cancel'
        TabOrder = 1
        OnClick = Button2Click
      end
    end
    object cbRunOnCompletion: TCheckBox
      Left = 355
      Top = 12
      Width = 137
      Height = 17
      Caption = 'Run script on completion'
      TabOrder = 1
    end
    object btnRun: TButton
      Left = 3
      Top = 9
      Width = 75
      Height = 25
      Hint = 'Result shown in right side panel'
      Caption = 'Run'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Visible = False
      OnClick = btnRunClick
    end
  end
  object Panel3: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 654
    Height = 296
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object mmInput: TMemo
      Left = 0
      Top = 0
      Width = 510
      Height = 296
      Hint = 'Eg: Connect via SSH and move images to server'
      Align = alClient
      Color = clDefault
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -12
      Font.Name = 'Consolas'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object mmOutput: TMemo
      Left = 510
      Top = 0
      Width = 144
      Height = 296
      Hint = 'Script Output'
      Align = alRight
      Color = clDefault
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -12
      Font.Name = 'Consolas'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Visible = False
    end
  end
end
