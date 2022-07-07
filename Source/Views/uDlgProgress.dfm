object DlgProgress: TDlgProgress
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Compressing Images'
  ClientHeight = 124
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 122
    Top = 52
    Width = 170
    Height = 13
    Alignment = taCenter
    Caption = 'Compressing images, please wait...'
  end
end
