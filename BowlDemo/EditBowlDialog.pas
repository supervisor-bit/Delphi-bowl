unit EditBowlDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BowlTypes;

type
  TEditBowlForm = class(TForm)
    LabelName: TLabel;
    EditName: TEdit;
    LabelPrice: TLabel;
    EditPrice: TEdit;
    LabelProducts: TLabel;
    ListProducts: TListBox;
    ButtonAddProduct: TButton;
    ButtonEditProduct: TButton;
    ButtonDeleteProduct: TButton;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    ButtonDeleteBowl: TButton;
    procedure FormShow(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonAddProductClick(Sender: TObject);
    procedure ButtonDeleteProductClick(Sender: TObject);
    procedure ButtonEditProductClick(Sender: TObject);
    procedure ButtonDeleteBowlClick(Sender: TObject);
  private
    FBowl: TBowl;
    FWasDeleted: Boolean;
    procedure RefreshProducts;
  public
    class function Execute(var Bowl: TBowl; out WasDeleted: Boolean): Boolean;
  end;

implementation

{$R *.dfm}

class function TEditBowlForm.Execute(var Bowl: TBowl; out WasDeleted: Boolean): Boolean;
var
  Form: TEditBowlForm;
begin
  Form := TEditBowlForm.Create(nil);
  try
    Form.FBowl := Bowl;
    Form.FWasDeleted := False;
    Result := (Form.ShowModal = mrOk);
    WasDeleted := Form.FWasDeleted;
    if Result and not WasDeleted then
      Bowl := Form.FBowl;
  finally
    Form.Free;
  end;
end;

procedure TEditBowlForm.FormShow(Sender: TObject);
begin
  EditName.Text := FBowl.Name;
  EditPrice.Text := CurrToStr(FBowl.Price);
  RefreshProducts;
end;

procedure TEditBowlForm.ButtonOKClick(Sender: TObject);
begin
  FBowl.Name := EditName.Text;
  FBowl.Price := StrToCurrDef(EditPrice.Text, 0);
  ModalResult := mrOk;
end;

procedure TEditBowlForm.RefreshProducts;
var
  i: Integer;
begin
  ListProducts.Items.Clear;
  for i := 0 to High(FBowl.Products) do
    ListProducts.Items.Add(
      FBowl.Products[i].Name + ' (' + FBowl.Products[i].Brand + ') — ' + FBowl.Products[i].Amount
    );
end;

procedure TEditBowlForm.ButtonAddProductClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := Length(FBowl.Products);
  SetLength(FBowl.Products, idx + 1);
  FBowl.Products[idx].Name := 'Nový produkt';
  FBowl.Products[idx].Brand := '';
  FBowl.Products[idx].Amount := '';
  RefreshProducts;
  ListProducts.ItemIndex := idx;
  EditName.SetFocus;
end;

procedure TEditBowlForm.ButtonDeleteProductClick(Sender: TObject);
var
  idx, i: Integer;
begin
  idx := ListProducts.ItemIndex;
  if (idx < 0) or (idx > High(FBowl.Products)) then Exit;
  for i := idx to High(FBowl.Products)-1 do
    FBowl.Products[i] := FBowl.Products[i+1];
  SetLength(FBowl.Products, Length(FBowl.Products)-1);
  RefreshProducts;
end;

procedure TEditBowlForm.ButtonEditProductClick(Sender: TObject);
var
  idx: Integer;
  s, brand, amount: string;
begin
  idx := ListProducts.ItemIndex;
  if (idx < 0) or (idx > High(FBowl.Products)) then Exit;
  s := InputBox('Název produktu', 'Zadejte název:', FBowl.Products[idx].Name);
  brand := InputBox('Značka produktu', 'Zadejte značku:', FBowl.Products[idx].Brand);
  amount := InputBox('Množství', 'Zadejte množství:', FBowl.Products[idx].Amount);
  FBowl.Products[idx].Name := s;
  FBowl.Products[idx].Brand := brand;
  FBowl.Products[idx].Amount := amount;
  RefreshProducts;
end;

procedure TEditBowlForm.ButtonDeleteBowlClick(Sender: TObject);
begin
  if MessageDlg('Opravdu chcete tuto misku smazat?', mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    FWasDeleted := True;
    ModalResult := mrOk;
  end;
end;

end.
