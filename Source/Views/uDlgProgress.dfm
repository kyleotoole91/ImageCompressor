object DlgProgress: TDlgProgress
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Compressing Images'
  ClientHeight = 101
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 82
    Top = 34
    Width = 170
    Height = 13
    Alignment = taCenter
    Caption = 'Compressing images, please wait...'
  end
  object pbProgress: TProgressBar
    AlignWithMargins = True
    Left = 6
    Top = 78
    Width = 329
    Height = 17
    Margins.Left = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 88
    ExplicitWidth = 409
  end
end
