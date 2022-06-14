object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight]
  Caption = 'Turbo Image Compressor - Evaluation'
  ClientHeight = 731
  ClientWidth = 1429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmFile
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
    Width = 1423
    Height = 690
    ActivePage = tsHome
    Align = alClient
    TabOrder = 0
    object tsHome: TTabSheet
      Caption = 'Home'
      object pnlMain: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1409
        Height = 656
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Splitter1: TSplitter
          Left = 155
          Top = 154
          Height = 502
          ExplicitLeft = 121
          ExplicitHeight = 443
        end
        object spOriginal: TSplitter
          Left = 784
          Top = 154
          Height = 502
          Align = alRight
          OnMoved = spOriginalMoved
          ExplicitLeft = 121
          ExplicitHeight = 443
        end
        object pnlConfig: TPanel
          Left = 0
          Top = 0
          Width = 1409
          Height = 154
          Align = alTop
          BevelOuter = bvNone
          Color = clBtnHighlight
          ParentBackground = False
          TabOrder = 0
          DesignSize = (
            1409
            154)
          object Label2: TLabel
            Left = 13
            Top = 15
            Width = 84
            Height = 13
            Caption = 'Source Directory:'
          end
          object Label1: TLabel
            Left = 13
            Top = 42
            Width = 85
            Height = 13
            Caption = 'Output Directory:'
          end
          object GroupBox1: TGroupBox
            Left = 159
            Top = 73
            Width = 268
            Height = 75
            TabOrder = 4
            object lbQuality: TLabel
              Left = 14
              Top = 20
              Width = 38
              Height = 13
              Caption = 'Quality:'
            end
            object lbTargetKB: TLabel
              Left = 116
              Top = 20
              Width = 59
              Height = 13
              Caption = 'Target (KB):'
            end
            object seQuality: TSpinEdit
              Left = 58
              Top = 17
              Width = 47
              Height = 22
              Hint = 'Values below 25 yeald poor results'
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
              Left = 181
              Top = 17
              Width = 80
              Height = 22
              Hint = 'Set to 0 to disable'
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
            object tbQuality: TTrackBar
              Left = 3
              Top = 45
              Width = 265
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
              OnChange = tbQualityChange
              OnKeyDown = tbQualityKeyDown
            end
          end
          object cbCompress: TCheckBox
            Left = 170
            Top = 66
            Width = 64
            Height = 17
            Hint = 'Maintaines aspect ratio'
            Caption = 'Compress'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = cbCompressClick
          end
          object GroupBox3: TGroupBox
            Left = 433
            Top = 73
            Width = 349
            Height = 75
            TabOrder = 6
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
              OnClick = SetShrinkState
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
            object seMaxWidthPx: TSpinEdit
              Left = 120
              Top = 18
              Width = 57
              Height = 22
              Hint = 'Set to 0 to disable'
              Enabled = False
              MaxValue = 0
              MinValue = 0
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Value = 1920
              OnExit = CheckCompressPreviewLoad
              OnKeyDown = seMaxWidthPxKeyDown
            end
            object seMaxHeightPx: TSpinEdit
              Left = 120
              Top = 45
              Width = 57
              Height = 22
              Hint = 'Set to 0 to disable'
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
              Left = 247
              Top = 19
              Width = 92
              Height = 21
              Enabled = False
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
              Left = 247
              Top = 46
              Width = 92
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
          end
          object ebStartPath: TEdit
            Left = 103
            Top = 12
            Width = 1304
            Height = 21
            Hint = 'Double click to show select dialog'
            Anchors = [akLeft, akTop, akRight]
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnChange = ebStartPathChange
            OnDblClick = ShowFolderSelect
            OnExit = ebStartPathExit
            OnKeyDown = ebStartPathKeyDown
          end
          object ebOutputDir: TEdit
            Left = 103
            Top = 39
            Width = 1304
            Height = 21
            Hint = 'Double click to show select dialog'
            Anchors = [akLeft, akTop, akRight]
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnDblClick = ShowFileSelect
          end
          object cbApplyGraphics: TCheckBox
            Left = 444
            Top = 66
            Width = 61
            Height = 17
            Caption = 'Graphics'
            TabOrder = 5
            OnClick = cbApplyGraphicsClick
          end
          object GroupBox4: TGroupBox
            Left = 0
            Top = 67
            Width = 153
            Height = 81
            Caption = ' Global '
            TabOrder = 2
            object lbFilename: TLabel
              Left = 18
              Top = 55
              Width = 46
              Height = 13
              Hint = '.json'
              Caption = 'Filename:'
              ParentShowHint = False
              ShowHint = True
            end
            object cbApplyToAll: TCheckBox
              Left = 18
              Top = 28
              Width = 108
              Height = 17
              Hint = 'Apply the current settings displayed when you click Start'
              Caption = 'Apply to all images'
              Checked = True
              ParentShowHint = False
              ShowHint = True
              State = cbChecked
              TabOrder = 0
              OnClick = cbCreateJSONFileClick
            end
            object ebFilename: TEdit
              Left = 70
              Top = 51
              Width = 75
              Height = 21
              Hint = 'Leaving blank will not create a JSON file.'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Text = 'images.json'
            end
          end
          object GroupBox2: TGroupBox
            Left = 788
            Top = 73
            Width = 619
            Height = 75
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 8
            DesignSize = (
              619
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
              Width = 521
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              Enabled = False
              TabOrder = 0
              Text = 'images/'
              OnChange = ebPrefixChange
            end
            object ebDescription: TEdit
              Left = 90
              Top = 45
              Width = 521
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              Enabled = False
              TabOrder = 1
              OnChange = ebDescriptionChange
            end
          end
          object cbCreateJSONFile: TCheckBox
            Left = 800
            Top = 66
            Width = 110
            Height = 17
            Caption = 'Include in JSON file'
            TabOrder = 7
            OnClick = cbCreateJSONFileClick
          end
        end
        object pnlFiles: TPanel
          Left = 0
          Top = 154
          Width = 155
          Height = 502
          Align = alLeft
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 1
          object lbFiles: TLabel
            Left = 3
            Top = 4
            Width = 83
            Height = 13
            Caption = 'Selected Images:'
            Enabled = False
          end
          object cblFiles: TCheckListBox
            AlignWithMargins = True
            Left = 0
            Top = 26
            Width = 151
            Height = 472
            Margins.Left = 0
            Margins.Top = 26
            Margins.Right = 0
            Margins.Bottom = 0
            OnClickCheck = cblFilesClickCheck
            Align = alClient
            BorderStyle = bsNone
            ItemHeight = 13
            PopupMenu = pmCheckBoxList
            TabOrder = 0
            OnClick = cblFilesClick
          end
        end
        object pnlImage: TPanel
          Left = 158
          Top = 154
          Width = 626
          Height = 502
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 2
          DesignSize = (
            622
            498)
          object imgHome: TImage
            AlignWithMargins = True
            Left = 3
            Top = 26
            Width = 616
            Height = 472
            Margins.Top = 26
            Margins.Bottom = 0
            Align = alClient
            AutoSize = True
            Proportional = True
            ExplicitLeft = 13
            ExplicitTop = 49
            ExplicitWidth = 450
            ExplicitHeight = 300
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
            Left = 341
            Top = 4
            Width = 46
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Size (KB):'
            Enabled = False
            ExplicitLeft = 340
          end
          object lbImgSizeKBVal: TLabel
            Left = 375
            Top = 4
            Width = 46
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Size (KB):'
            Enabled = False
            ExplicitLeft = 374
          end
          object lbImgWidth: TLabel
            Left = 436
            Top = 4
            Width = 55
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Width (px):'
            Enabled = False
            ExplicitLeft = 435
          end
          object lbImgWidthVal: TLabel
            Left = 467
            Top = 4
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'lbImgWidth'
            Enabled = False
            ExplicitLeft = 466
          end
          object lbImgHeight: TLabel
            Left = 528
            Top = 4
            Width = 58
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Height (px):'
            Enabled = False
            ExplicitLeft = 527
          end
          object lbImgHeightVal: TLabel
            Left = 564
            Top = 4
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'lbImgWidth'
            Enabled = False
            ExplicitLeft = 563
          end
          object cbCompressPreview: TCheckBox
            Left = 117
            Top = 3
            Width = 124
            Height = 17
            Caption = 'Preview Compression'
            Enabled = False
            TabOrder = 1
            OnClick = CheckCompressPreviewLoad
          end
          object cbStretch: TCheckBox
            Left = 57
            Top = 3
            Width = 60
            Height = 17
            Caption = 'Stretch'
            Enabled = False
            TabOrder = 0
            OnClick = cbStretchClick
          end
        end
        object pnlOriginal: TPanel
          Left = 787
          Top = 154
          Width = 622
          Height = 502
          Align = alRight
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 3
          DesignSize = (
            618
            498)
          object lbImgOrigSize: TLabel
            Left = 321
            Top = 4
            Width = 46
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Size (KB):'
            ExplicitLeft = 324
          end
          object lbImgOrigSizeKBVal: TLabel
            Left = 371
            Top = 4
            Width = 31
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'SizeKB'
            ExplicitLeft = 374
          end
          object lbImgOrigWidth: TLabel
            Left = 414
            Top = 4
            Width = 55
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Width (px):'
            ExplicitLeft = 417
          end
          object lbImgOrigWidthVal: TLabel
            Left = 449
            Top = 4
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'lbImgWidth'
            ExplicitLeft = 452
          end
          object lbImgOrigHeight: TLabel
            Left = 520
            Top = 4
            Width = 58
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Height (px):'
            ExplicitLeft = 523
          end
          object lbImgOrigHeightVal: TLabel
            Left = 557
            Top = 4
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'lbImgWidth'
            ExplicitLeft = 560
          end
          object imgOriginal: TImage
            AlignWithMargins = True
            Left = 3
            Top = 26
            Width = 612
            Height = 472
            Margins.Top = 26
            Margins.Bottom = 0
            Align = alClient
            AutoSize = True
            Proportional = True
            ExplicitLeft = 80
            ExplicitTop = 88
            ExplicitWidth = 543
            ExplicitHeight = 404
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
            Caption = 'Stretch'
            TabOrder = 0
            OnClick = cbStretchOriginalClick
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
        Width = 1409
        Height = 656
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object mmMessages: TMemo
          Left = 0
          Top = 0
          Width = 1409
          Height = 656
          Align = alClient
          Lines.Strings = (
            'mmMessages')
          PopupMenu = pmResults
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 696
    Width = 1429
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      1429
      35)
    object btnStart: TButton
      Left = 1344
      Top = 3
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Start'
      Enabled = False
      TabOrder = 1
      OnClick = btnStartClick
    end
    object btnScan: TButton
      Left = 1082
      Top = 3
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Scan'
      TabOrder = 2
      Visible = False
      OnClick = btnScanClick
    end
    object cbDeepScan: TCheckBox
      Left = 433
      Top = 3
      Width = 70
      Height = 17
      Caption = 'Deep Scan'
      TabOrder = 3
      Visible = False
    end
    object btnApply: TButton
      Left = 1258
      Top = 3
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Apply'
      Enabled = False
      TabOrder = 0
      OnClick = btnApplyClick
    end
  end
  object pmCheckBoxList: TPopupMenu
    Left = 122
    Top = 318
    object mniUnSelectAll: TMenuItem
      Caption = 'Deselect All'
      OnClick = mniUnSelectAllClick
    end
    object mniSelectAll: TMenuItem
      Caption = 'Select All'
      OnClick = mniSelectAllClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Refresh1: TMenuItem
      Caption = 'Refresh'
      OnClick = Refresh1Click
    end
  end
  object pmResults: TPopupMenu
    Left = 186
    Top = 278
    object miClear: TMenuItem
      Caption = 'Clear'
      OnClick = miClearClick
    end
  end
  object mmFile: TMainMenu
    Left = 144
    object File1: TMenuItem
      Caption = 'File'
      object mmiScan: TMenuItem
        Caption = 'Open Folder'
        OnClick = ShowFolderSelect
      end
      object mmiOpen: TMenuItem
        Caption = 'Open JPG'
        OnClick = ShowFileSelect
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object miHideConfig: TMenuItem
        Caption = 'Hide Config'
        OnClick = miHideConfigClick
      end
      object miHideFiles: TMenuItem
        Caption = 'Hide Images Found'
        OnClick = miHideFilesClick
      end
      object miHideOriginal: TMenuItem
        Caption = 'Hide Original'
        OnClick = miHideOriginalClick
      end
      object miApplyBestFit: TMenuItem
        Caption = 'Apply Best Fit'
        Checked = True
        Hint = 'Improves image preview quality for large images'
        OnClick = miApplyBestFitClick
      end
    end
    object miUpgrade: TMenuItem
      Caption = 'License'
      object miPurchaseLicense: TMenuItem
        Caption = 'Purchase License Key'
        OnClick = miPurchaseLicenseClick
      end
      object miEnterLicense: TMenuItem
        Caption = 'Enter License Key'
        OnClick = miEnterLicenseClick
      end
    end
  end
end
