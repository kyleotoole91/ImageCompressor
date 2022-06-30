object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight]
  Caption = 'Turbo Image Compressor - Pro'
  ClientHeight = 950
  ClientWidth = 1644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
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
    Width = 1638
    Height = 909
    ActivePage = tsHome
    Align = alClient
    TabOrder = 0
    object tsHome: TTabSheet
      Caption = 'Home'
      object pnlMain: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1624
        Height = 875
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Splitter1: TSplitter
          Left = 247
          Top = 154
          Height = 721
          ExplicitLeft = 121
          ExplicitHeight = 443
        end
        object spOriginal: TSplitter
          Left = 1192
          Top = 154
          Height = 721
          Align = alRight
          OnMoved = spOriginalMoved
          ExplicitLeft = 121
          ExplicitHeight = 443
        end
        object pnlConfig: TPanel
          Left = 0
          Top = 0
          Width = 1624
          Height = 154
          Align = alTop
          BevelOuter = bvNone
          Color = clBtnHighlight
          ParentBackground = False
          TabOrder = 0
          DesignSize = (
            1624
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
            Left = 0
            Top = 73
            Width = 245
            Height = 75
            TabOrder = 3
            object lbQuality: TLabel
              Left = 11
              Top = 21
              Width = 38
              Height = 13
              Caption = 'Quality:'
            end
            object lbTargetKB: TLabel
              Left = 103
              Top = 20
              Width = 59
              Height = 13
              Caption = 'Target (KB):'
            end
            object seQuality: TSpinEdit
              Left = 55
              Top = 17
              Width = 42
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
              Left = 168
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
              OnChange = seTargetKBsChange
              OnExit = CheckCompressPreviewLoad
              OnKeyDown = seTargetKBsKeyDown
            end
            object tbQuality: TTrackBar
              Left = 3
              Top = 45
              Width = 238
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
            Left = 11
            Top = 66
            Width = 80
            Height = 17
            Hint = 'Maintaines aspect ratio'
            Caption = 'Compression'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = cbCompressClick
          end
          object GroupBox3: TGroupBox
            Left = 251
            Top = 73
            Width = 349
            Height = 75
            TabOrder = 5
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
              Hint = 'Press Enter or leave field to Apply. Set to 0 to disable'
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
            Width = 1520
            Height = 21
            Hint = 'Double click to show select dialog. Press Enter to apply'
            Anchors = [akLeft, akTop, akRight]
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnDblClick = ShowFolderSelect
            OnKeyDown = ebStartPathKeyDown
          end
          object ebOutputDir: TEdit
            Left = 103
            Top = 39
            Width = 1520
            Height = 21
            Hint = 'Double click to show select dialog'
            Anchors = [akLeft, akTop, akRight]
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnDblClick = ShowFileSelect
          end
          object cbApplyGraphics: TCheckBox
            Left = 262
            Top = 66
            Width = 61
            Height = 17
            Hint = 'Reduce size, rotate and resample for improved image quality'
            Caption = 'Graphics'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            OnClick = cbApplyGraphicsClick
          end
          object GroupBox4: TGroupBox
            Left = 1471
            Top = 67
            Width = 152
            Height = 81
            Anchors = [akTop, akRight, akBottom]
            Caption = ' Globals '
            TabOrder = 7
            object lbFilename: TLabel
              Left = 9
              Top = 56
              Width = 46
              Height = 13
              Hint = '.json'
              Caption = 'Filename:'
              ParentShowHint = False
              ShowHint = True
            end
            object cbApplyToAll: TCheckBox
              Left = 9
              Top = 25
              Width = 120
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
              Left = 61
              Top = 52
              Width = 84
              Height = 21
              Hint = 'Leaving blank will not create a JSON file.'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Text = 'images.json'
            end
          end
          object GroupBox2: TGroupBox
            Left = 606
            Top = 73
            Width = 859
            Height = 75
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 8
            DesignSize = (
              859
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
              Width = 761
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
              Width = 761
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              Enabled = False
              TabOrder = 1
              OnChange = ebDescriptionChange
            end
          end
          object cbCreateJSONFile: TCheckBox
            Left = 618
            Top = 66
            Width = 110
            Height = 17
            Caption = 'Include in JSON file'
            TabOrder = 6
            OnClick = cbCreateJSONFileClick
          end
        end
        object pnlFiles: TPanel
          Left = 0
          Top = 154
          Width = 247
          Height = 721
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
          end
          object cblFiles: TCheckListBox
            AlignWithMargins = True
            Left = 0
            Top = 26
            Width = 243
            Height = 691
            Hint = 'Drap and drop images'
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
          Top = 154
          Width = 942
          Height = 721
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 2
          DesignSize = (
            938
            717)
          object imgHome: TImage
            AlignWithMargins = True
            Left = 3
            Top = 26
            Width = 932
            Height = 691
            Margins.Top = 26
            Margins.Bottom = 0
            Align = alClient
            AutoSize = True
            PopupMenu = pmViews
            Proportional = True
            ExplicitLeft = 5
            ExplicitTop = 27
            ExplicitWidth = 908
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
            Left = 654
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
          end
          object lbImgSizeKBVal: TLabel
            Left = 690
            Top = 4
            Width = 46
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Size (KB):'
            Enabled = False
          end
          object lbImgWidth: TLabel
            Left = 742
            Top = 4
            Width = 55
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Width (px):'
            Enabled = False
          end
          object lbImgWidthVal: TLabel
            Left = 780
            Top = 4
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'lbImgWidth'
            Enabled = False
          end
          object lbImgHeight: TLabel
            Left = 840
            Top = 4
            Width = 58
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Height (px):'
            Enabled = False
          end
          object lbImgHeightVal: TLabel
            Left = 880
            Top = 4
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'lbImgWidth'
            Enabled = False
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
            Hint = 'May reduce image preview quality'
            Caption = 'Stretch'
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = cbStretchClick
          end
        end
        object pnlOriginal: TPanel
          Left = 1195
          Top = 154
          Width = 429
          Height = 721
          Align = alRight
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 3
          DesignSize = (
            425
            717)
          object lbImgOrigSize: TLabel
            Left = 144
            Top = 4
            Width = 46
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Size (KB):'
          end
          object lbImgOrigSizeKBVal: TLabel
            Left = 194
            Top = 4
            Width = 31
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'SizeKB'
          end
          object lbImgOrigWidth: TLabel
            Left = 231
            Top = 4
            Width = 55
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Width (px):'
          end
          object lbImgOrigWidthVal: TLabel
            Left = 266
            Top = 4
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'lbImgWidth'
          end
          object lbImgOrigHeight: TLabel
            Left = 325
            Top = 4
            Width = 58
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Height (px):'
          end
          object lbImgOrigHeightVal: TLabel
            Left = 364
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
            Width = 419
            Height = 691
            Margins.Top = 26
            Margins.Bottom = 0
            Align = alClient
            AutoSize = True
            PopupMenu = pmViews
            Proportional = True
            ExplicitLeft = 1
            ExplicitTop = 27
            ExplicitWidth = 345
            ExplicitHeight = 388
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
            Hint = 'May reduce image preview quality'
            Caption = 'Stretch'
            ParentShowHint = False
            ShowHint = True
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
        Width = 1624
        Height = 875
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object mmMessages: TMemo
          Left = 0
          Top = 0
          Width = 1624
          Height = 875
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
    Top = 915
    Width = 1644
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      1644
      35)
    object btnStart: TButton
      Left = 1559
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
      Left = 1297
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
      Left = 1473
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
    Left = 122
    Top = 318
    object mniSelectAll: TMenuItem
      Caption = 'Select All'
      OnClick = mniSelectAllClick
    end
    object mniUnSelectAll: TMenuItem
      Caption = 'Deselect All'
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
  end
  object pmResults: TPopupMenu
    Left = 186
    Top = 278
    object miClear: TMenuItem
      Caption = 'Clear'
      OnClick = miClearClick
    end
  end
  object mmMenu: TMainMenu
    Left = 144
    object File1: TMenuItem
      Caption = 'File'
      object mmiScan: TMenuItem
        Caption = 'Open Folder'
        ShortCut = 113
        OnClick = ShowFolderSelect
      end
      object mmiOpen: TMenuItem
        Caption = 'Open JPG'
        ShortCut = 114
        OnClick = ShowFileSelect
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object CloseApplication1: TMenuItem
        Caption = 'Close Application'
        OnClick = CloseApplication1Click
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object miHideFiles: TMenuItem
        Caption = 'Hide Selected Images'
        ShortCut = 112
        OnClick = miHideFilesClick
      end
      object miHideConfig: TMenuItem
        Caption = 'Hide Configuration'
        OnClick = miHideConfigClick
      end
      object miHideOriginal: TMenuItem
        Caption = 'Hide Original Image'
        OnClick = miHideOriginalClick
      end
      object miFullscreen: TMenuItem
        Caption = 'Fullscreen'
        ShortCut = 123
        OnClick = miFullscreenClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miApplyBestFit: TMenuItem
        Caption = 'Scale to fit (better quality)'
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
      OnClick = Settings1Click
      object miDeepScan: TMenuItem
        Caption = 'Deep Scan '
        OnClick = miDeepScanClick
      end
      object miReplaceOriginals: TMenuItem
        Caption = 'Replace Originals (save disk space)'
        Hint = 'Save disk space'
        OnClick = miReplaceOriginalsClick
      end
      object miSaveSettings: TMenuItem
        Caption = 'Save Current Settings'
        OnClick = miSaveSettingsClick
      end
    end
    object miUpgrade: TMenuItem
      Caption = 'Product'
      ShortCut = 115
      object miPurchaseLicense: TMenuItem
        Caption = 'Purchase License Key'
        OnClick = miPurchaseLicenseClick
      end
      object miEnterLicense: TMenuItem
        Caption = 'Enter License Key'
        OnClick = miEnterLicenseClick
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object miDownload: TMenuItem
        Caption = 'Download Latest Version'
        OnClick = miDownloadClick
      end
      object miContact: TMenuItem
        Caption = 'Contact Support'
        OnClick = miContactClick
      end
    end
  end
  object pmViews: TPopupMenu
    OnPopup = pmViewsPopup
    Left = 512
    Top = 296
    object miSplit: TMenuItem
      Caption = 'Split'
      OnClick = miSplitClick
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
end
