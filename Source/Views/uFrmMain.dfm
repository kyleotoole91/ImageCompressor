object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight]
  Caption = 'Turbo Image Compressor - Pro'
  ClientHeight = 950
  ClientWidth = 1522
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = mmMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 570
    Top = 173
    Width = 81
    Height = 13
    Caption = 'Max Height (Px):'
    Enabled = False
    Visible = False
  end
  object pcMain: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1516
    Height = 909
    ActivePage = tsHome
    Align = alClient
    TabOrder = 0
    OnChange = pcMainChange
    object tsHome: TTabSheet
      Caption = 'Home'
      object pnlMain: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 156
        Width = 1502
        Height = 722
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        object spFiles: TSplitter
          Left = 247
          Top = 0
          Height = 722
          OnMoved = spFilesMoved
          ExplicitLeft = 121
          ExplicitTop = 154
          ExplicitHeight = 443
        end
        object spOriginal: TSplitter
          Left = 1124
          Top = 0
          Height = 722
          Align = alRight
          OnMoved = spOriginalMoved
          ExplicitLeft = 121
          ExplicitTop = 154
          ExplicitHeight = 443
        end
        object pnlFiles: TPanel
          Left = 0
          Top = 0
          Width = 247
          Height = 722
          Align = alLeft
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 0
          object lbFiles: TLabel
            Left = 3
            Top = 4
            Width = 83
            Height = 13
            Caption = 'Selected Images:'
          end
          object cblFiles: TCheckListBox
            AlignWithMargins = True
            Left = 0
            Top = 26
            Width = 243
            Height = 692
            Hint = 'Drag and drop images and directories'
            Margins.Left = 0
            Margins.Top = 26
            Margins.Right = 0
            Margins.Bottom = 0
            OnClickCheck = cblFilesClickCheck
            Align = alClient
            BorderStyle = bsNone
            ItemHeight = 13
            ParentShowHint = False
            PopupMenu = pmCheckBoxList
            ShowHint = True
            TabOrder = 0
            OnClick = cblFilesClick
          end
        end
        object pnlImage: TPanel
          Left = 250
          Top = 0
          Width = 874
          Height = 722
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 1
          DesignSize = (
            870
            718)
          object imgHome: TImage
            AlignWithMargins = True
            Left = 3
            Top = 26
            Width = 864
            Height = 692
            Hint = 'Drag and drop images and directories'
            Margins.Top = 26
            Margins.Bottom = 0
            Align = alClient
            AutoSize = True
            ParentShowHint = False
            PopupMenu = pmViews
            Proportional = True
            ShowHint = False
            ExplicitLeft = 5
            ExplicitTop = 27
            ExplicitWidth = 908
            ExplicitHeight = 691
          end
          object lbImage: TLabel
            Left = 3
            Top = 4
            Width = 42
            Height = 13
            Caption = 'Preview:'
            Enabled = False
          end
          object lbImgSizeKB: TLabel
            Left = 586
            Top = 4
            Width = 46
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Size (KB):'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 654
          end
          object lbImgSizeKBVal: TLabel
            Left = 662
            Top = 4
            Width = 6
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = '0'
            Enabled = False
            ExplicitLeft = 720
          end
          object lbImgWidth: TLabel
            Left = 674
            Top = 4
            Width = 55
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Width (px):'
            Enabled = False
            ExplicitLeft = 742
          end
          object lbImgWidthVal: TLabel
            Left = 760
            Top = 4
            Width = 6
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = '0'
            Enabled = False
            ExplicitLeft = 818
          end
          object lbImgHeight: TLabel
            Left = 772
            Top = 4
            Width = 58
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Height (px):'
            Enabled = False
            ExplicitLeft = 840
          end
          object lbImgHeightVal: TLabel
            Left = 860
            Top = 4
            Width = 6
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = '0'
            Enabled = False
            ExplicitLeft = 918
          end
          object cbCompressPreview: TCheckBox
            Left = 117
            Top = 3
            Width = 124
            Height = 17
            Hint = 
              'Tip: Apply settings for improved performance when toggling Previ' +
              'ew Compression '
            Caption = 'Preview Compression'
            Enabled = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 1
            OnClick = CheckCompressPreviewLoad
          end
          object cbStretch: TCheckBox
            Left = 57
            Top = 3
            Width = 60
            Height = 17
            Hint = 'May reduce image preview qualty'
            Caption = 'Stretch'
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = cbStretchClick
          end
        end
        object pnlOriginal: TPanel
          Left = 1127
          Top = 0
          Width = 375
          Height = 722
          Align = alRight
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 2
          DesignSize = (
            371
            718)
          object lbImgOrigSize: TLabel
            Left = 90
            Top = 4
            Width = 46
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Size (KB):'
            ExplicitLeft = 144
          end
          object lbImgOrigSizeKBVal: TLabel
            Left = 165
            Top = 4
            Width = 6
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = '0'
            ExplicitLeft = 229
          end
          object lbImgOrigWidth: TLabel
            Left = 177
            Top = 4
            Width = 55
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Width (px):'
            ExplicitLeft = 231
          end
          object lbImgOrigWidthVal: TLabel
            Left = 260
            Top = 4
            Width = 6
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = '0'
            ExplicitLeft = 324
          end
          object lbImgOrigHeight: TLabel
            Left = 271
            Top = 4
            Width = 58
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Height (px):'
            ExplicitLeft = 325
          end
          object lbImgOrigHeightVal: TLabel
            Left = 358
            Top = 4
            Width = 6
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = '0'
            ExplicitLeft = 422
          end
          object imgOriginal: TImage
            AlignWithMargins = True
            Left = 3
            Top = 26
            Width = 365
            Height = 692
            Margins.Top = 26
            Margins.Bottom = 0
            Align = alClient
            AutoSize = True
            PopupMenu = pmViews
            Proportional = True
            ExplicitLeft = 1
            ExplicitTop = 27
            ExplicitWidth = 419
            ExplicitHeight = 691
          end
          object Label4: TLabel
            Left = 3
            Top = 4
            Width = 40
            Height = 13
            Caption = 'Original:'
            WordWrap = True
          end
          object cbStretchOriginal: TCheckBox
            Left = 55
            Top = 3
            Width = 56
            Height = 17
            Hint = 'May reduce image preview qualty'
            Caption = 'Stretch'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = cbStretchOriginalClick
          end
        end
      end
      object pnlConfig: TPanel
        Left = 0
        Top = 0
        Width = 1508
        Height = 65
        Align = alTop
        BevelOuter = bvNone
        Color = clBtnHighlight
        ParentBackground = False
        TabOrder = 0
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 1508
          Height = 60
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            1508
            60)
          object lbOutputDir: TLabel
            Left = 13
            Top = 42
            Width = 85
            Height = 13
            Caption = 'Output Directory:'
          end
          object Label2: TLabel
            Left = 14
            Top = 15
            Width = 84
            Height = 13
            Caption = 'Source Directory:'
          end
          object ebStartPath: TEdit
            Left = 104
            Top = 12
            Width = 1398
            Height = 21
            Hint = 'Double click to show select dialog. Press Enter to apply'
            Anchors = [akLeft, akTop, akRight]
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnDblClick = ebStartPathDblClick
            OnKeyDown = ebStartPathKeyDown
          end
          object ebOutputDir: TEdit
            Left = 104
            Top = 39
            Width = 1398
            Height = 21
            Hint = 'Double click to show select dialog'
            Anchors = [akLeft, akTop, akRight]
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnChange = ebOutputDirChange
            OnDblClick = ebOutputDirDblClick
          end
        end
      end
      object pnlConfigFlow: TFlowPanel
        AlignWithMargins = True
        Left = 0
        Top = 65
        Width = 1508
        Height = 85
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object pnlCompression: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 370
          Height = 85
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object GroupBox1: TGroupBox
            AlignWithMargins = True
            Left = 0
            Top = 6
            Width = 370
            Height = 79
            Margins.Left = 0
            Margins.Top = 6
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 1
            DesignSize = (
              370
              79)
            object lbQuality: TLabel
              Left = 27
              Top = 23
              Width = 3
              Height = 13
            end
            object lbTargetKB: TLabel
              Left = 215
              Top = 22
              Width = 3
              Height = 13
            end
            object seQuality: TSpinEdit
              Left = 69
              Top = 19
              Width = 50
              Height = 22
              Hint = 'Press Enter key or leave field to set the value'
              MaxValue = 100
              MinValue = 10
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Value = 90
              OnExit = seQualityExit
              OnKeyDown = seQualityKeyDown
            end
            object seTargetKBs: TSpinEdit
              Left = 280
              Top = 19
              Width = 82
              Height = 22
              Hint = ' Set to 0 to disable'
              Enabled = False
              MaxValue = 0
              MinValue = 0
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Value = 0
              OnChange = seTargetKBsChange
              OnExit = CheckCompressPreviewLoad
              OnKeyDown = seTargetKBsKeyDown
            end
            object rbQuality: TRadioButton
              Left = 9
              Top = 16
              Width = 54
              Height = 25
              Caption = 'Quality:'
              Checked = True
              TabOrder = 2
              TabStop = True
              OnClick = rbQualityClick
            end
            object rbTarget: TRadioButton
              Left = 200
              Top = 16
              Width = 74
              Height = 25
              Caption = 'Target (KB):'
              TabOrder = 3
              OnClick = rbTargetClick
            end
            object tbQuality: TTrackBar
              Left = 1
              Top = 47
              Width = 368
              Height = 20
              Hint = 'Quality'
              Anchors = [akLeft, akTop, akRight]
              DoubleBuffered = True
              Max = 100
              Min = 10
              ParentDoubleBuffered = False
              ParentShowHint = False
              PageSize = 1
              Position = 90
              ShowHint = True
              TabOrder = 4
              TickStyle = tsNone
              OnChange = tbQualityChange
              OnKeyDown = tbQualityKeyDown
            end
          end
          object cbCompress: TCheckBox
            Left = 9
            Top = -2
            Width = 80
            Height = 17
            Hint = 'Maintaines aspect ratio'
            Caption = 'Compression'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = cbCompressClick
          end
        end
        object pnlGraphics: TPanel
          AlignWithMargins = True
          Left = 379
          Top = 0
          Width = 370
          Height = 85
          Margins.Top = 0
          Margins.Bottom = 0
          BevelOuter = bvNone
          TabOrder = 1
          object GroupBox3: TGroupBox
            AlignWithMargins = True
            Left = 0
            Top = 6
            Width = 370
            Height = 79
            Margins.Left = 0
            Margins.Top = 6
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 1
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
              Left = 190
              Top = 21
              Width = 58
              Height = 13
              Caption = 'Resampling:'
              Enabled = False
            end
            object lbRotation: TLabel
              Left = 203
              Top = 48
              Width = 45
              Height = 13
              Caption = 'Rotation:'
              Enabled = False
            end
            object seMaxWidthPx: TSpinEdit
              Left = 120
              Top = 17
              Width = 57
              Height = 22
              Hint = 'Press Enter or leave field to Apply. Set to 0 to disable'
              Enabled = False
              MaxValue = 0
              MinValue = 0
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              Value = 1920
              OnExit = CheckCompressPreviewLoad
              OnKeyDown = seMaxWidthPxKeyDown
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
              OnExit = CheckCompressPreviewLoad
              OnKeyDown = seMaxHeightPxKeyDown
            end
            object cbResampleMode: TComboBox
              Left = 254
              Top = 19
              Width = 106
              Height = 21
              Hint = 
                'Higher values result in improved quality when resizing and/or ro' +
                'tating'
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              Text = 'Recommened '
              OnChange = cbResampleModeChange
              OnExit = cbResampleModeExit
              OnKeyDown = cbResampleModeKeyDown
              Items.Strings = (
                'None'
                'Fastest'
                'Recommended '
                'Best')
            end
            object cbRotateAmount: TComboBox
              Left = 254
              Top = 46
              Width = 106
              Height = 21
              Enabled = False
              ItemIndex = 0
              TabOrder = 5
              Text = 'None'
              OnChange = CheckCompressPreviewLoad
              OnExit = cbRotateAmountExit
              OnKeyDown = cbRotateAmountKeyDown
              Items.Strings = (
                'None'
                '90'#176
                '180'#176
                '270'#176)
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
              OnClick = SetShrinkState
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
              TabOrder = 1
              OnClick = SetShrinkState
            end
          end
          object cbApplyGraphics: TCheckBox
            Left = 9
            Top = -1
            Width = 61
            Height = 17
            Hint = 'Reduce size, rotate and resample for improved image quality'
            Caption = 'Graphics'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = cbApplyGraphicsClick
          end
        end
        object pnlIncludeInFile: TPanel
          AlignWithMargins = True
          Left = 755
          Top = 0
          Width = 370
          Height = 85
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 2
          object GroupBox2: TGroupBox
            AlignWithMargins = True
            Left = 0
            Top = 6
            Width = 370
            Height = 79
            Margins.Left = 0
            Margins.Top = 6
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 1
            DesignSize = (
              370
              79)
            object lbDescription: TLabel
              Left = 11
              Top = 48
              Width = 57
              Height = 13
              Caption = 'Description:'
              Enabled = False
            end
            object lbTitle: TLabel
              Left = 44
              Top = 22
              Width = 24
              Height = 13
              Caption = 'Title:'
              Enabled = False
            end
            object ebDescription: TEdit
              Left = 74
              Top = 46
              Width = 288
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              Enabled = False
              TabOrder = 1
              OnChange = ebDescriptionChange
            end
            object ebTitle: TEdit
              Left = 74
              Top = 19
              Width = 288
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              Enabled = False
              TabOrder = 0
              OnChange = ebDescriptionChange
            end
          end
          object cbIncludeInJSONFile: TCheckBox
            Left = 11
            Top = -1
            Width = 110
            Height = 17
            Caption = 'Include in JSON file'
            TabOrder = 0
            OnClick = cbIncludeInJSONFileClick
          end
        end
        object pnlGlobals: TPanel
          AlignWithMargins = True
          Left = 1131
          Top = 0
          Width = 370
          Height = 85
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 3
          object GroupBox4: TGroupBox
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 370
            Height = 85
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            Caption = ' Globals '
            TabOrder = 0
            DesignSize = (
              370
              85)
            object lbFilename: TLabel
              Left = 211
              Top = 25
              Width = 46
              Height = 13
              Hint = '.json'
              Caption = 'Filename:'
              ParentShowHint = False
              ShowHint = True
            end
            object lbPrefix: TLabel
              AlignWithMargins = True
              Left = 22
              Top = 52
              Width = 68
              Height = 13
              Caption = 'Source Prefix:'
            end
            object cbApplyToAll: TCheckBox
              Left = 15
              Top = 23
              Width = 75
              Height = 17
              Hint = 'Use the same settings for all the selected images'
              Caption = 'Apply to all '
              Checked = True
              ParentShowHint = False
              ShowHint = True
              State = cbChecked
              TabOrder = 0
              OnClick = cbIncludeInJSONFileClick
            end
            object ebFilename: TEdit
              Left = 263
              Top = 22
              Width = 97
              Height = 21
              Hint = 'Leaving blank will not create a JSON file.'
              Anchors = [akLeft, akTop, akRight]
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              Text = 'images.json'
            end
            object ebPrefix: TEdit
              Left = 96
              Top = 49
              Width = 264
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 3
              Text = 'images/Compressed'
              OnChange = ebPrefixChange
            end
            object cbCreateThumbnails: TCheckBox
              Left = 96
              Top = 23
              Width = 109
              Height = 17
              Hint = 'Use the same settings for all the selected images'
              Caption = 'Create thumbnails'
              Checked = True
              ParentShowHint = False
              ShowHint = True
              State = cbChecked
              TabOrder = 1
              OnClick = cbIncludeInJSONFileClick
            end
          end
        end
      end
    end
    object tsLogs: TTabSheet
      Caption = 'Logs'
      ImageIndex = 1
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1502
        Height = 875
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object spScript: TSplitter
          Left = 0
          Top = 416
          Width = 1502
          Height = 6
          Cursor = crVSplit
          Align = alBottom
          ExplicitLeft = 16
          ExplicitTop = 589
          ExplicitWidth = 1624
        end
        object pnlLogs: TPanel
          Left = 0
          Top = 0
          Width = 1502
          Height = 416
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 1502
            Height = 19
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = ' Compression logs:'
            TabOrder = 0
          end
          object mmMessages: TMemo
            Left = 0
            Top = 19
            Width = 1502
            Height = 397
            Align = alClient
            Lines.Strings = (
              'mmMessages')
            PopupMenu = pmLogs
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 1
          end
        end
        object pnlScript: TPanel
          Left = 0
          Top = 422
          Width = 1502
          Height = 453
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 1502
            Height = 17
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = 'Script logs:'
            TabOrder = 0
          end
          object mmScript: TMemo
            Left = 0
            Top = 17
            Width = 1502
            Height = 436
            Align = alClient
            Color = clNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlightText
            Font.Height = -12
            Font.Name = 'Consolas'
            Font.Style = []
            Lines.Strings = (
              'mmMessages')
            ParentFont = False
            PopupMenu = pmScriptLogs
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 1
          end
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 915
    Width = 1522
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      1522
      35)
    object lbClientWidth: TLabel
      Left = 7
      Top = 16
      Width = 63
      Height = 13
      Caption = 'lbClientWidth'
      Visible = False
    end
    object lbClientHeight: TLabel
      Left = 111
      Top = 14
      Width = 66
      Height = 13
      Caption = 'lbClientHeight'
      Visible = False
    end
    object btnStart: TButton
      Left = 1437
      Top = 3
      Width = 80
      Height = 25
      Hint = 'Start processing all of the selected images'
      Anchors = [akTop, akRight]
      Caption = 'Start'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnStartClick
    end
    object btnScan: TButton
      Left = 1175
      Top = 3
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Scan'
      TabOrder = 2
      Visible = False
      OnClick = btnScanClick
    end
    object btnApply: TButton
      Left = 1351
      Top = 3
      Width = 80
      Height = 25
      Hint = 'Apply settings to the current image'
      Anchors = [akTop, akRight]
      Caption = 'Apply'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnApplyClick
    end
  end
  object pmCheckBoxList: TPopupMenu
    OnPopup = pmCheckBoxListPopup
    Left = 194
    Top = 198
    object mniSelectAll: TMenuItem
      Caption = 'Select all'
      OnClick = mniSelectAllClick
    end
    object mniUnSelectAll: TMenuItem
      Caption = 'Deselect all'
      OnClick = mniUnSelectAllClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Refresh1: TMenuItem
      Caption = 'Refresh'
      OnClick = Refresh1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Hide1: TMenuItem
      Caption = 'Hide'
      OnClick = miHideImageListClick
    end
    object miClearFiles: TMenuItem
      Caption = 'Clear'
      OnClick = miClearFilesClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object miShowInGallery: TMenuItem
      Caption = 'Open in Gallery'
      OnClick = miShowInGalleryClick
    end
    object miOpenWith: TMenuItem
      Caption = 'Open in Paint'
      OnClick = miOpenWithClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object miShowInExplorer: TMenuItem
      Caption = 'Show in folder'
      OnClick = miShowInExplorerClick
    end
  end
  object pmLogs: TPopupMenu
    Left = 306
    Top = 262
    object miClear: TMenuItem
      Caption = 'Clear'
      OnClick = miClearClick
    end
  end
  object mmMenu: TMainMenu
    Left = 144
    object File1: TMenuItem
      Caption = 'File'
      object mmiOpenFolder: TMenuItem
        Caption = 'Open folder'
        ShortCut = 113
        OnClick = mmiOpenFolderClick
      end
      object mmiOpen: TMenuItem
        Caption = 'Add JPGs'
        ShortCut = 114
        OnClick = mmiOpenClick
      end
      object miSelectOutputDir: TMenuItem
        Caption = 'Select output folder'
        OnClick = miSelectOutputDirClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object miFileSaveSettings: TMenuItem
        Caption = 'Save current settings'
        OnClick = miFileSaveSettingsClick
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object CloseApplication1: TMenuItem
        Caption = 'Close '
        OnClick = CloseApplication1Click
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object miHideFiles: TMenuItem
        Caption = 'Hide selected images'
        ShortCut = 112
        OnClick = miHideFilesClick
      end
      object miHideConfig: TMenuItem
        Caption = 'Hide configuration'
        ShortCut = 120
        OnClick = miHideConfigClick
      end
      object miHideOriginal: TMenuItem
        Caption = 'Hide original image'
        ShortCut = 121
        OnClick = miHideOriginalClick
      end
      object miFullscreen: TMenuItem
        Caption = 'Fullscreen'
        ShortCut = 123
        OnClick = miFullscreenClick
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object ClearImageList1: TMenuItem
        Caption = 'Clear Image List'
        OnClick = ClearImageList1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miApplyBestFit: TMenuItem
        Caption = 'Auto Scale (improves preview quality)'
        Checked = True
        Hint = 'Improves image preview quality for large images'
        ShortCut = 122
        OnClick = miApplyBestFitClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object miRefresh: TMenuItem
        Caption = 'Refresh'
        ShortCut = 116
        OnClick = miRefreshClick
      end
    end
    object Filter1: TMenuItem
      Caption = 'Filter'
      object miFilesSizeFilter: TMenuItem
        Caption = 'Files larger than (KB)'
        ShortCut = 115
        OnClick = miFilesSizeFilterClick
      end
    end
    object Settings1: TMenuItem
      Caption = 'Settings'
      object miDeepScan: TMenuItem
        Caption = 'Deep scan '
        ShortCut = 117
        OnClick = miDeepScanClick
      end
      object miReplaceOriginals: TMenuItem
        Caption = 'Replace originals (save disk space)'
        Hint = 'Save disk space'
        OnClick = miReplaceOriginalsClick
      end
      object miAutoPrefix: TMenuItem
        Caption = 'Auto source prefix (append output dir name)'
        OnClick = miAutoPrefixClick
      end
      object cbSetThumbnailSize: TMenuItem
        Caption = 'Set thumbnail size'
        OnClick = cbSetThumbnailSizeClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object miSaveSettings: TMenuItem
        Caption = 'Save current settings'
        OnClick = miSaveSettingsClick
      end
      object miRestoreDefaults: TMenuItem
        Caption = 'Restore defaults'
        OnClick = miRestoreDefaultsClick
      end
    end
    object miAdvanced: TMenuItem
      Caption = 'Advanced'
      object miDeploymentScript: TMenuItem
        Caption = 'Deployment script'
        OnClick = miDeploymentScriptClick
      end
    end
    object miUpgrade: TMenuItem
      Caption = 'Product'
      ShortCut = 115
      object miPurchaseLicense: TMenuItem
        Caption = 'Purchase license key'
        OnClick = miPurchaseLicenseClick
      end
      object miEnterLicense: TMenuItem
        Caption = 'Enter license key'
        OnClick = miEnterLicenseClick
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object miDownload: TMenuItem
        Caption = 'Download latest version'
        OnClick = miDownloadClick
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object miContact: TMenuItem
        Caption = 'Contact support'
        OnClick = miContactClick
      end
    end
  end
  object pmViews: TPopupMenu
    OnPopup = pmViewsPopup
    Left = 408
    Top = 320
    object miSplit: TMenuItem
      Caption = 'Split'
      OnClick = miSplitClick
    end
    object StretchandSplit1: TMenuItem
      Caption = 'Stretch and Split'
      OnClick = StretchandSplit1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object miHideOriginalPm: TMenuItem
      Caption = 'Hide Original'
      OnClick = miHideOriginalPmClick
    end
    object miHideImageList: TMenuItem
      Caption = 'Hide Selected Images'
      OnClick = miHideImageListClick
    end
    object miImgFullscreen: TMenuItem
      Caption = 'Fullscreen'
      OnClick = miFullscreenClick
    end
  end
  object tmrOnShow: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrOnShowTimer
    Left = 388
    Top = 248
  end
  object pmScriptLogs: TPopupMenu
    Left = 306
    Top = 342
    object miClearSciptLogs: TMenuItem
      Caption = 'Clear'
      OnClick = miClearSciptLogsClick
    end
  end
end
