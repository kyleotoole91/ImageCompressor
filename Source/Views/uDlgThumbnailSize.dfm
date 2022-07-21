object DlgThumbnailSize: TDlgThumbnailSize
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Thumbnail dimensions'
  ClientHeight = 81
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 29
    Top = 19
    Width = 130
    Height = 13
    Caption = 'Max width and height (px):'
  end
  object btnOK: TButton
    Left = 165
    Top = 44
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 246
    Top = 44
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object seMaxDimensions: TSpinEdit
    Left = 165
    Top = 16
    Width = 156
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
end
