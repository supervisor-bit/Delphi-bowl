unit BowlEditForm;

interface

uses
  System.Classes, Vcl.Forms, Vcl.StdCtrls, BowlTypesDesign, Vcl.Controls, Vcl.ExtCtrls, System.SysUtils;

type
  TfrmBowlEdit = class(TForm)
    lblName: TLabel;
    edtName: TEdit;
    lbProducts: TListBox;
    btnAddProduct: TButton;
    btnEditProduct: TButton;
    btnDeleteProduct: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnAddProductClick(Sender: TObject);
    procedure btnDeleteProductClick(Sender: TObject);
    procedure btnEditProductClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lbProductsDblClick(Sender: TObject);
  private
    FBowl: TDesignBowl;
    procedure RefreshProducts;
    procedure EditProduct(AIndex: Integer);
  public
    // Pokud je Bowl nil, vytvoří se nová miska
    class function Execute(var Bowl: TDesignBowl; Collection: TDesignBowls): Boolean;
  end;

implementation
{$R *.dfm}

uses
  Vcl.Dialogs;

function EditProductDialog(Product: TDesignBowlProduct): Boolean;
var
  name, brand, amountStr: string;
  amount: Integer;
begin
  name := Product.Name;
  brand := Product.Brand;
  amountStr := IntToStr(Product.Amount);
  if InputQuery('Úprava produktu', 'Název:', name) and
     InputQuery('Úprava produktu', 'Značka:', brand) and
     InputQuery('Úprava produktu', 'Množství:', amountStr) then
  begin
    if TryStrToInt(amountStr, amount) then
    begin
      Product.Name := name;
      Product.Brand := brand;
      Product.Amount := amount;
      Result := True;
    end else
    begin
      MessageDlg('Množství musí být číslo!', mtError, [mbOK], 0);
      Result := False;
    end;
  end else
    Result := False;
end;

{ TfrmBowlEdit }

procedure TfrmBowlEdit.FormShow(Sender: TObject);
begin
  if Assigned(FBowl) then
  begin
    edtName.Text := FBowl.Name;
    RefreshProducts;
  end;
end;

procedure TfrmBowlEdit.RefreshProducts;
var
  i: Integer;
  prod: TDesignBowlProduct;
begin
  lbProducts.Items.Clear;
  if Assigned(FBowl) and Assigned(FBowl.Products) then
    for i := 0 to FBowl.Products.Count - 1 do
    begin
      prod := FBowl.Products[i];
      lbProducts.Items.Add(Format('%s [%s] x%d', [prod.Name, prod.Brand, prod.Amount]));
    end;
end;

procedure TfrmBowlEdit.btnAddProductClick(Sender: TObject);
var
  prod: TDesignBowlProduct;
begin
  prod := FBowl.Products.Add as TDesignBowlProduct;
  prod.Name := 'Nový produkt';
  prod.Brand := '';
  prod.Amount := 1;
  if EditProductDialog(prod) then
    RefreshProducts
  else
    FBowl.Products.Delete(FBowl.Products.Count - 1);
end;

procedure TfrmBowlEdit.btnEditProductClick(Sender: TObject);
begin
  EditProduct(lbProducts.ItemIndex);
end;

procedure TfrmBowlEdit.EditProduct(AIndex: Integer);
begin
  if (AIndex >= 0) and (AIndex < FBowl.Products.Count) then
    if EditProductDialog(FBowl.Products[AIndex]) then
      RefreshProducts;
end;

procedure TfrmBowlEdit.btnDeleteProductClick(Sender: TObject);
begin
  if lbProducts.ItemIndex >= 0 then
  begin
    FBowl.Products.Delete(lbProducts.ItemIndex);
    RefreshProducts;
  end;
end;

procedure TfrmBowlEdit.btnOKClick(Sender: TObject);
begin
  FBowl.Name := edtName.Text;
  ModalResult := mrOk;
end;

procedure TfrmBowlEdit.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmBowlEdit.lbProductsDblClick(Sender: TObject);
begin
  EditProduct(lbProducts.ItemIndex);
end;

// Pokud je Bowl nil, přidá se nová miska do kolekce
class function TfrmBowlEdit.Execute(var Bowl: TDesignBowl; Collection: TDesignBowls): Boolean;
var
  frm: TfrmBowlEdit;
  NewBowl: TDesignBowl;
begin
  frm := TfrmBowlEdit.Create(nil);
  try
    if Bowl = nil then
    begin
      NewBowl := Collection.Add as TDesignBowl;
      frm.FBowl := NewBowl;
    end
    else
      frm.FBowl := Bowl;

    Result := frm.ShowModal = mrOk;
    if Result then
      Bowl := frm.FBowl
    else if Bowl = nil then // pokud byl vytvořen nový a uživatel dal storno, smaž ho
    begin
      Collection.Delete(Collection.Count - 1);
      Bowl := nil;
    end;
  finally
    frm.Free;
  end;
end;

end.