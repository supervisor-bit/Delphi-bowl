unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BowlListControl, BowlTypesDesign,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    BowlListControl1: TBowlListControl;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BowlListControl1Selected(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses BowlEditForm;

procedure TForm1.BowlListControl1Selected(Sender: TObject);
var
  idx, i: Integer;
  bowl: TDesignBowl;
  prod: TDesignBowlProduct;
  s: string;
begin
  idx := BowlListControl1.SelectedIndex;
  if (idx >= 0) and (idx < BowlListControl1.Bowls.Count) then
  begin
    bowl := BowlListControl1.Bowls[idx];
    s := 'Miska: ' + bowl.Name + sLineBreak +
         'Produkty:' + sLineBreak;
    for i := 0 to bowl.Products.Count - 1 do
    begin
      prod := bowl.Products[i];
      s := s + Format('  - %s [%s] x%d', [prod.Name, prod.Brand, prod.Amount]) + sLineBreak;
    end;
    ShowMessage(s);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  NewBowl: TDesignBowl;
begin
  NewBowl := nil;
  if TfrmBowlEdit.Execute(NewBowl, BowlListControl1.Bowls) then
  begin
    BowlListControl1.RefreshBowls;
    BowlListControl1.SelectedIndex := BowlListControl1.Bowls.Count - 1; // vybere novou misku
    application.ProcessMessages;
    BowlListControl1.ScrollToSelected;                                  // scrollne na ni
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  idx: Integer;
  bowl: TDesignBowl;
begin
  idx := BowlListControl1.SelectedIndex;
  if (idx >= 0) and (idx < BowlListControl1.Bowls.Count) then
  begin
    bowl := BowlListControl1.Bowls[idx];
    if TfrmBowlEdit.Execute(bowl, BowlListControl1.Bowls) then
    begin
      BowlListControl1.RefreshBowls; // Tím se znovu pøemìøí a rozloí vıšky všech BowlItemù
      // Pokud chceš zùstat na stejné poloce:
      BowlListControl1.SelectedIndex := idx;
      BowlListControl1.ScrollToSelectedDelayed;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  idx: Integer;
begin
  idx := BowlListControl1.SelectedIndex;
  if (idx >= 0) and (idx < BowlListControl1.Bowls.Count) then
  begin
    if MessageDlg('Opravdu chceš tuto misku smazat?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      BowlListControl1.Bowls.Delete(idx);
      BowlListControl1.RefreshBowls;
    end;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  bowl: TDesignBowl;
  prod: TDesignBowlProduct;
begin
BowlListControl1.VertScrollBar.Visible := True;

  // Pøidání první misky
  bowl := BowlListControl1.Bowls.Add as TDesignBowl;
  bowl.Name := 'Snídaòová miska';

  prod := bowl.Products.Add as TDesignBowlProduct;
  prod.Name := 'Jablko';
  prod.Brand := 'Biofarma';
  prod.Amount := 2;

  prod := bowl.Products.Add as TDesignBowlProduct;
  prod.Name := 'Jogurt';
  prod.Brand := 'Hollandia';
  prod.Amount := 1;

  // Pøidání druhé misky
  bowl := BowlListControl1.Bowls.Add as TDesignBowl;
  bowl.Name := 'Obìdová miska';

  prod := bowl.Products.Add as TDesignBowlProduct;
  prod.Name := 'Kuøe';
  prod.Brand := 'Domácí';
  prod.Amount := 1;

  prod := bowl.Products.Add as TDesignBowlProduct;
  prod.Name := 'Rıe';
  prod.Brand := 'Uncle Ben''s';
  prod.Amount := 1;

  BowlListControl1.RefreshBowls;

  // Nastav handler na OnSelected (dùleité!)
  BowlListControl1.OnSelected := BowlListControl1Selected;
end;

end.
