unit BowlItem;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Graphics, BowlTypesDesign, Winapi.Windows, System.SysUtils, Winapi.Messages;

type
  TBowlItem = class(TCustomControl)
  private
    FBowl: TDesignBowl;
    FSelected: Boolean;
    FReadOnly: Boolean;
    FHover: Boolean;
    FOnSelected: TNotifyEvent;
    procedure SetSelected(Value: Boolean);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure Paint; override;
    procedure Click; override;
  public
    property Bowl: TDesignBowl read FBowl write FBowl;
    property Selected: Boolean read FSelected write SetSelected;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property OnSelected: TNotifyEvent read FOnSelected write FOnSelected;
    constructor Create(AOwner: TComponent); override;
    procedure AdjustHeight;
  end;

implementation

constructor TBowlItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Height := 90;
  Width := 400;
  DoubleBuffered := True;
end;

procedure TBowlItem.SetSelected(Value: Boolean);
begin
  if FSelected <> Value then
  begin
    FSelected := Value;
    Invalidate;
  end;
end;

procedure TBowlItem.Click;
begin
  inherited;
  if Assigned(FOnSelected) then
    FOnSelected(Self);
end;

procedure TBowlItem.CMMouseEnter(var Message: TMessage);
begin
  FHover := True;
  Invalidate;
end;

procedure TBowlItem.CMMouseLeave(var Message: TMessage);
begin
  FHover := False;
  Invalidate;
end;

procedure TBowlItem.AdjustHeight;
const
  HeaderHeight = 45;
  ProductRowHeight = 34;
begin
  if Assigned(FBowl) then
  begin
    if FBowl.Products.Count = 0 then
      Height := HeaderHeight + ProductRowHeight // aspoò jeden øádek pro "Žádné produkty"
    else
      Height := HeaderHeight + FBowl.Products.Count * ProductRowHeight;
  end
  else
    Height := HeaderHeight + ProductRowHeight;
end;

procedure TBowlItem.Paint;
const
  BowlTitleFontSize = 11;
  ProductFontSize = 10;
  BowlRectRadius = 8;
  ShadowOffset = 2;
  TitleOffsetY = 10;
  AmountWidth = 60;
var
  j: Integer;
  r: TRect;
  prodY: Integer;
  sTitle, amountDisplay: string;
  BorderColor: TColor;
  prod: TDesignBowlProduct;
begin
  r := Rect(0, 0, Width, Height);

  // Stín
  Canvas.Pen.Style := psClear;
  Canvas.Brush.Color := $00ECECEC;
  Canvas.RoundRect(r.Left + ShadowOffset, r.Top + ShadowOffset, r.Right - 1 + ShadowOffset, r.Bottom - 1 + ShadowOffset, BowlRectRadius, BowlRectRadius);

  // Pozadí
  if FSelected then
    Canvas.Brush.Color := $00FFF4CC  // svìtle žlutá pro vybranou
  else if FHover and not FReadOnly then
    Canvas.Brush.Color := $00FFF7ED
  else
    Canvas.Brush.Color := clWhite;

  // Rámeèek
  if FSelected then
    BorderColor := $00F9B000  // oranžový rámeèek
  else
    BorderColor := $00D0D0D0; // šedý rámeèek

  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Color := BorderColor;
  Canvas.RoundRect(r.Left, r.Top, r.Right - 1, r.Bottom - 1, BowlRectRadius, BowlRectRadius);

  // Titulek (pouze název misky)
  if Assigned(FBowl) then
    sTitle := FBowl.Name
  else
    sTitle := '';
  Canvas.Font.Size := BowlTitleFontSize;
  Canvas.Font.Style := [];
  Canvas.Font.Color := clBlack;
  Canvas.TextOut(r.Left + 12, r.Top + TitleOffsetY, sTitle);

  // Produkty (bez ID, pouze název, množství a znaèka)
  Canvas.Font.Size := ProductFontSize;
  Canvas.Font.Style := [];
  prodY := r.Top + TitleOffsetY + 25;
  if Assigned(FBowl) then
    if FBowl.Products.Count = 0 then
    begin
      Canvas.Font.Color := clGray;
      Canvas.TextOut(r.Left + 16, prodY, 'Žádné produkty');
    end
    else
      for j := 0 to FBowl.Products.Count - 1 do
      begin
        prod := FBowl.Products[j];
        Canvas.Font.Color := clBlack;
        Canvas.TextOut(r.Left + 16, prodY, prod.Name);

        Canvas.Font.Color := clGray;
        amountDisplay := '';
        if prod.Amount > 0 then
          amountDisplay := IntToStr(prod.Amount) + ' g';
        Canvas.TextOut(r.Right - AmountWidth, prodY, amountDisplay);

        Canvas.Font.Color := clGray;
        Canvas.Font.Style := [];
        Canvas.TextOut(r.Left + 36, prodY + 15, prod.Brand);

        prodY := prodY + 34;
      end;
end;

end.
