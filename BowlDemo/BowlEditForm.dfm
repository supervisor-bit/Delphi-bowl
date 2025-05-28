object frmBowlEdit: TfrmBowlEdit
  Left = 0
  Top = 0
  Caption = 'Editace misky'
  ClientHeight = 281
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object lblName: TLabel
    Left = 16
    Top = 16
    Width = 75
    Height = 15
    Caption = 'N'#258#711'zev misky:'
  end
  object edtName: TEdit
    Left = 100
    Top = 13
    Width = 250
    Height = 23
    TabOrder = 0
  end
  object lbProducts: TListBox
    Left = 16
    Top = 48
    Width = 334
    Height = 150
    ItemHeight = 15
    TabOrder = 1
    OnDblClick = lbProductsDblClick
  end
  object btnAddProduct: TButton
    Left = 16
    Top = 210
    Width = 100
    Height = 25
    Caption = 'P'#313#8482'idat produkt'
    TabOrder = 2
    OnClick = btnAddProductClick
  end
  object btnEditProduct: TButton
    Left = 126
    Top = 210
    Width = 100
    Height = 25
    Caption = 'Upravit produkt'
    TabOrder = 3
    OnClick = btnEditProductClick
  end
  object btnDeleteProduct: TButton
    Left = 236
    Top = 210
    Width = 100
    Height = 25
    Caption = 'Smazat produkt'
    TabOrder = 4
    OnClick = btnDeleteProductClick
  end
  object btnOK: TButton
    Left = 160
    Top = 250
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 5
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 250
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Storno'
    ModalResult = 2
    TabOrder = 6
    OnClick = btnCancelClick
  end
end
