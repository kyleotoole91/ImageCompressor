object FrmDefaultConfig: TFrmDefaultConfig
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Default Compression Settings '
  ClientHeight = 312
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 12
    Top = 14
    Width = 349
    Height = 75
    TabOrder = 1
    object lbQuality: TLabel
      Left = 11
      Top = 21
      Width = 38
      Height = 13
      Caption = 'Quality:'
    end
    object lbTargetKB: TLabel
      Left = 209
      Top = 20
      Width = 59
      Height = 13
      Caption = 'Target (KB):'
    end
    object seQuality: TSpinEdit
      Left = 55
      Top = 17
      Width = 50
      Height = 22
      Hint = 'Press Enter key or leave field to set the value'
      MaxValue = 100
      MinValue = 10
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 90
    end
    object seTargetKBs: TSpinEdit
      Left = 274
      Top = 17
      Width = 65
      Height = 22
      Hint = 
        ' Will reduce scale if needed to reach the target. Set to 0 to di' +
        'sable'
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 0
    end
    object tbQuality: TTrackBar
      Left = 3
      Top = 45
      Width = 346
      Height = 20
      Hint = 'Quality'
      DoubleBuffered = True
      Max = 100
      Min = 10
      ParentDoubleBuffered = False
      ParentShowHint = False
      PageSize = 1
      Position = 90
      ShowHint = True
      TabOrder = 2
      TickStyle = tsNone
    end
  end
  object cbCompress: TCheckBox
    Left = 23
    Top = 7
    Width = 64
    Height = 17
    Hint = 'Maintaines aspect ratio'
    Caption = 'Compress'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object GroupBox3: TGroupBox
    Left = 12
    Top = 100
    Width = 349
    Height = 75
    TabOrder = 3
    object lbMaxHeightPx: TLabel
      Left = 87
      Top = 49
      Width = 27
      Height = 13
      Caption = ' (px):'
      Enabled = False
    end
    object lbMaxWidthPx: TLabel
      Left = 87
      Top = 22
      Width = 27
      Height = 13
      Caption = ' (px):'
      Enabled = False
    end
    object lbResampling: TLabel
      Left = 183
      Top = 21
      Width = 58
      Height = 13
      Caption = 'Resampling:'
      Enabled = False
    end
    object lbRotation: TLabel
      Left = 196
      Top = 48
      Width = 45
      Height = 13
      Caption = 'Rotation:'
      Enabled = False
    end
    object rbByHeight: TRadioButton
      Left = 17
      Top = 47
      Width = 70
      Height = 17
      Hint = 'Maintains aspect ratio'
      Caption = 'Max Height'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object rbByWidth: TRadioButton
      Left = 17
      Top = 20
      Width = 70
      Height = 17
      Hint = 'Maintains aspect ratio'
      Caption = 'Max Width'
      Checked = True
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = True
    end
    object seMaxWidthPx: TSpinEdit
      Left = 120
      Top = 18
      Width = 57
      Height = 22
      Hint = 'Press Enter or leave field to Apply. Set to 0 to disable'
      Enabled = False
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 1920
    end
    object seMaxHeightPx: TSpinEdit
      Left = 120
      Top = 45
      Width = 57
      Height = 22
      Hint = 'Press Enter or leave field to Apply. Set to 0 to disable.'
      Enabled = False
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Value = 1080
    end
    object cbResampleMode: TComboBox
      Left = 247
      Top = 19
      Width = 92
      Height = 21
      Hint = 
        'Higher values result in improved quality when resizing and/or ro' +
        'tating'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Text = 'Recommened '
      Items.Strings = (
        'None'
        'Fastest'
        'Recommended '
        'Best')
    end
    object cbRotateAmount: TComboBox
      Left = 247
      Top = 46
      Width = 92
      Height = 21
      Enabled = False
      ItemIndex = 0
      TabOrder = 5
      Text = 'None'
      Items.Strings = (
        'None'
        '90'#176
        '180'#176
        '270'#176)
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 188
    Width = 349
    Height = 75
    TabOrder = 5
    DesignSize = (
      349
      75)
    object lbPrefix: TLabel
      AlignWithMargins = True
      Left = 16
      Top = 19
      Width = 68
      Height = 13
      Caption = 'Source Prefix:'
      Enabled = False
    end
    object lbDescription: TLabel
      Left = 27
      Top = 48
      Width = 57
      Height = 13
      Caption = 'Description:'
      Enabled = False
    end
    object ebPrefix: TEdit
      Left = 90
      Top = 17
      Width = 251
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      TabOrder = 0
      Text = 'images/'
    end
    object ebDescription: TEdit
      Left = 90
      Top = 45
      Width = 251
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      TabOrder = 1
    end
  end
  object cbApplyGraphics: TCheckBox
    Left = 24
    Top = 93
    Width = 61
    Height = 17
    Caption = 'Graphics'
    TabOrder = 2
  end
  object cbCreateJSONFile: TCheckBox
    Left = 20
    Top = 180
    Width = 110
    Height = 17
    Caption = 'Include in JSON file'
    TabOrder = 4
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 268
    Width = 371
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object Panel2: TPanel
      Left = 128
      Top = 0
      Width = 243
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object Button2: TButton
        Left = 164
        Top = 12
        Width = 75
        Height = 25
        Caption = 'Cancel'
        TabOrder = 0
        OnClick = Button2Click
      end
      object btnOK: TButton
        Left = 83
        Top = 12
        Width = 75
        Height = 25
        Caption = 'OK'
        TabOrder = 1
        OnClick = btnOKClick
      end
    end
  end
end
