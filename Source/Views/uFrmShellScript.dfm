object FrmShellScript: TFrmShellScript
  Left = 0
  Top = 0
  Caption = 'Deployment Script Editor (.bat)'
  ClientHeight = 548
  ClientWidth = 1308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 507
    Width = 1308
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 388
    ExplicitWidth = 1070
    object Panel2: TPanel
      Left = 878
      Top = 0
      Width = 430
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 640
      object btnOK: TButton
        Left = 269
        Top = 8
        Width = 75
        Height = 25
        Caption = 'OK'
        Enabled = False
        TabOrder = 1
        OnClick = btnOKClick
      end
      object btnClose: TButton
        Left = 350
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Close'
        TabOrder = 2
        OnClick = btnCloseClick
      end
      object btnRun: TButton
        Left = 188
        Top = 8
        Width = 75
        Height = 25
        Hint = 'Result shown in right side panel'
        Caption = 'Run'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnRunClick
      end
      object cbRunOnCompletion: TCheckBox
        Left = 24
        Top = 12
        Width = 158
        Height = 17
        Caption = 'Run script after compressing'
        TabOrder = 3
        OnClick = cbRunOnCompletionClick
      end
    end
  end
  object Panel3: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1302
    Height = 501
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 1064
    ExplicitHeight = 382
    object Splitter1: TSplitter
      Left = 845
      Top = 0
      Height = 501
      Align = alRight
      ExplicitLeft = 424
      ExplicitTop = -3
      ExplicitHeight = 296
    end
    object mmInput: TMemo
      Left = 0
      Top = 0
      Width = 845
      Height = 501
      Hint = 
        'Eg: Execute commands to transfer images via SCP and import the .' +
        'json into database'
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
      ScrollBars = ssBoth
      ShowHint = True
      TabOrder = 0
      OnChange = mmInputChange
      ExplicitWidth = 640
      ExplicitHeight = 382
    end
    object mmOutput: TMemo
      Left = 848
      Top = 0
      Width = 454
      Height = 501
      Hint = 'Output'
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
      ReadOnly = True
      ScrollBars = ssBoth
      ShowHint = True
      TabOrder = 1
    end
  end
  object MainMenu1: TMainMenu
    Left = 211
    Top = 59
    object Insert1: TMenuItem
      Caption = 'Add Variable'
      object cbInsertVar: TMenuItem
        Caption = 'Output Directory'
        OnClick = cbInsertVarClick
      end
      object Sourceprefixsaved1: TMenuItem
        Caption = 'Source prefix'
        OnClick = Sourceprefixsaved1Click
      end
    end
  end
end
