object DlgFilter: TDlgFilter
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Filter'
  ClientHeight = 80
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 25
    Top = 17
    Width = 118
    Height = 13
    Caption = 'Images larger than (KB):'
  end
  object SpinEdit1: TSpinEdit
    Left = 149
    Top = 14
    Width = 156
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object Button1: TButton
    Left = 230
    Top = 42
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 149
    Top = 42
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button2Click
  end
end
