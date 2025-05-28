object EditBowlForm: TEditBowlForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Editace misky'
  ClientHeight = 291
  ClientWidth = 344
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object LabelName: TLabel
    Left = 16
    Top = 16
    Width = 98
    Height = 15
    Caption = 'N'#258#711'zev procedury:'
  end
  object LabelPrice: TLabel
    Left = 16
    Top = 46
    Width = 30
    Height = 15
    Caption = 'Cena:'
  end
  object LabelProducts: TLabel
    Left = 16
    Top = 80
    Width = 51
    Height = 15
    Caption = 'Produkty:'
  end
  object EditName: TEdit
    Left = 120
    Top = 14
    Width = 200
    Height = 23
    TabOrder = 0
  end
  object EditPrice: TEdit
    Left = 120
    Top = 44
    Width = 80
    Height = 23
    TabOrder = 1
  end
  object ListProducts: TListBox
    Left = 16
    Top = 100
    Width = 304
    Height = 100
    ItemHeight = 15
    TabOrder = 2
  end
  object ButtonAddProduct: TButton
    Left = 16
    Top = 210
    Width = 90
    Height = 25
    Caption = 'P'#313#8482'idat'
    TabOrder = 3
    OnClick = ButtonAddProductClick
  end
  object ButtonEditProduct: TButton
    Left = 116
    Top = 210
    Width = 90
    Height = 25
    Caption = 'Upravit'
    TabOrder = 4
    OnClick = ButtonEditProductClick
  end
  object ButtonDeleteProduct: TButton
    Left = 216
    Top = 210
    Width = 90
    Height = 25
    Caption = 'Smazat'
    TabOrder = 5
    OnClick = ButtonDeleteProductClick
  end
  object ButtonOK: TButton
    Left = 128
    Top = 250
    Width = 90
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 6
    OnClick = ButtonOKClick
  end
  object ButtonCancel: TButton
    Left = 224
    Top = 250
    Width = 90
    Height = 25
    Caption = 'Storno'
    ModalResult = 2
    TabOrder = 7
  end
  object ButtonDeleteBowl: TButton
    Left = 16
    Top = 250
    Width = 90
    Height = 25
    Caption = 'Smazat misku'
    ModalResult = 1
    TabOrder = 8
    OnClick = ButtonDeleteBowlClick
  end
end
