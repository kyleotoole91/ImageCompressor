object FrmShellScript: TFrmShellScript
  Left = 0
  Top = 0
  Caption = 'Deployment Script (.bat)'
  ClientHeight = 343
  ClientWidth = 734
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
    Width = 734
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 660
    object Panel2: TPanel
      Left = 304
      Top = 0
      Width = 430
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnOK: TButton
        Left = 271
        Top = 7
        Width = 75
        Height = 25
        Caption = 'Save'
        TabOrder = 1
        OnClick = btnOKClick
      end
      object btnCancel: TButton
        Left = 352
        Top = 7
        Width = 75
        Height = 25
        Caption = 'Cancel'
        TabOrder = 2
        OnClick = btnCancelClick
      end
      object btnRun: TButton
        Left = 190
        Top = 7
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
        Left = 26
        Top = 11
        Width = 158
        Height = 17
        Caption = 'Run script after compressing'
        TabOrder = 3
      end
    end
  end
  object Panel3: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 728
    Height = 296
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 654
    object Splitter1: TSplitter
      Left = 373
      Top = 0
      Height = 296
      Align = alRight
      ExplicitLeft = 424
      ExplicitTop = -3
    end
    object mmInput: TMemo
      Left = 0
      Top = 0
      Width = 373
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
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 0
    end
    object mmOutput: TMemo
      Left = 376
      Top = 0
      Width = 352
      Height = 296
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
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 1
    end
  end
end
