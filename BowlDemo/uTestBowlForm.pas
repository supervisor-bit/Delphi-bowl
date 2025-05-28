unit uTestBowlForm;
interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Generics.Collections, BowlTypes, BowlItem, BowlListControl;

type
  TFormTestBowl = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    BowlList: TBowlListControl;
    Bowls: TObjectList<TBowl>;
    procedure BowlListSelected(Sender: TObject);
  public
  end;

var
  FormTestBowl: TFormTestBowl;

implementation

{$R *.dfm}

procedure TFormTestBowl.FormCreate(Sender: TObject);
var
  B: TBowl;
  P: TBowlProduct;
begin
  // Inicializace kolekce misek
  Bowls := TObjectList<TBowl>.Create(True);

  // 1. miska
  B := TBowl.Create;
  B.Name := 'Melír';
  P := TBowlProduct.Create; P.Name := 'Práškový melír'; P.Brand := 'Londa'; P.Amount := 32; B.Products.Add(P);
  P := TBowlProduct.Create; P.Name := 'Peroxid 6%'; P.Brand := 'Londa'; P.Amount := 48; B.Products.Add(P);
  Bowls.Add(B);

  // 2. miska
  B := TBowl.Create;
  B.Name := 'Barvení';
  P := TBowlProduct.Create; P.Name := 'Barva 8/0'; P.Brand := 'Schwarzkopf'; P.Amount := 40; B.Products.Add(P);
  P := TBowlProduct.Create; P.Name := 'Peroxid 3%'; P.Brand := 'Schwarzkopf'; P.Amount := 40; B.Products.Add(P);
  Bowls.Add(B);

  // 3. miska (prázdná)
  B := TBowl.Create;
  B.Name := 'Tónování';
  Bowls.Add(B);

  // Vytvoøení vizuální komponenty
  BowlList := TBowlListControl.Create(Self);
  BowlList.Parent := Self;
  BowlList.Align := alClient;
  BowlList.Bowls := Bowls;
  BowlList.OnSelected := BowlListSelected;
end;

procedure TFormTestBowl.FormDestroy(Sender: TObject);
begin
  BowlList.Free;
  Bowls.Free;
end;

procedure TFormTestBowl.BowlListSelected(Sender: TObject);
begin
  if BowlList.SelectedIndex >= 0 then
    Caption := 'Vybrána miska: ' + Bowls[BowlList.SelectedIndex].Name
  else
    Caption := 'Žádná miska nevybrána';
end;

end.
