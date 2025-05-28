unit BowlListControl;

interface

uses
  System.Classes, Vcl.Controls, BowlTypesDesign, BowlItem,
  Vcl.Forms, Winapi.Messages, Winapi.Windows, Vcl.ExtCtrls;

type
  TBowlListControl = class(TScrollBox)
  private
    FBowls: TDesignBowls;
    FSelectedIndex: Integer;
    FOnSelected: TNotifyEvent;
    procedure SetBowls(Value: TDesignBowls);
    procedure LayoutBowls;
    procedure BowlItemSelected(Sender: TObject);
    procedure ResizeHandler(Sender: TObject);
    procedure SetSelectedIndex(const Value: Integer);
    procedure WMDoDelayedScroll(var Msg: TMessage); message WM_USER + 123;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RefreshBowls;
    procedure ScrollToSelected;
    procedure ScrollToSelectedDelayed;
    property Bowls: TDesignBowls read FBowls write SetBowls;
    property SelectedIndex: Integer read FSelectedIndex write SetSelectedIndex;
  published
    property OnSelected: TNotifyEvent read FOnSelected write FOnSelected;
  end;

procedure Register;

implementation

uses
  System.SysUtils, Vcl.Dialogs;

constructor TBowlListControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBowls := TDesignBowls.Create(Self);
  VertScrollBar.Tracking := True;
  OnResize := ResizeHandler;
  FSelectedIndex := -1;
end;

destructor TBowlListControl.Destroy;
begin
  FBowls.Free;
  inherited;
end;

procedure TBowlListControl.SetBowls(Value: TDesignBowls);
begin
  FBowls.Assign(Value);
  RefreshBowls;
end;

procedure TBowlListControl.RefreshBowls;
var
  i: Integer;
  BowlItem: TBowlItem;
begin
  while ControlCount > 0 do
    Controls[0].Free;
  for i := 0 to FBowls.Count - 1 do
  begin
    BowlItem := TBowlItem.Create(Self);
    BowlItem.Parent := Self;
    BowlItem.Bowl := FBowls[i];
    BowlItem.OnSelected := BowlItemSelected;
    BowlItem.Tag := i;
    BowlItem.Selected := (i = FSelectedIndex);
    BowlItem.Align := alNone;
    BowlItem.Width := ClientWidth - 16;
    BowlItem.AdjustHeight;
  end;
  LayoutBowls;
  Update;
end;

procedure TBowlListControl.LayoutBowls;
var
  i, topPos: Integer;
  BowlItem: TBowlItem;
  DummyPanel: TPanel;
begin
  topPos := 12;
  for i := 0 to ControlCount - 1 do
    if Controls[i] is TBowlItem then
    begin
      BowlItem := TBowlItem(Controls[i]);
      BowlItem.Width := ClientWidth - 16;
      BowlItem.Left := 8;
      BowlItem.Top := topPos;
      BowlItem.AdjustHeight;
      topPos := topPos + BowlItem.Height + 16;
    end;
  // Smaž pøedchozí dummy panel (pokud existuje)
  for i := ControlCount - 1 downto 0 do
    if (Controls[i] is TPanel) and (Controls[i].Tag = -99) then
      Controls[i].Free;
  // Pøidej dummy panel na konec
  DummyPanel := TPanel.Create(Self);
  DummyPanel.Parent := Self;
  DummyPanel.Visible := False;
  DummyPanel.Tag := -99;
  DummyPanel.SetBounds(8, topPos, 1, 100);
end;

procedure TBowlListControl.ResizeHandler(Sender: TObject);
begin
  LayoutBowls;
end;

procedure TBowlListControl.BowlItemSelected(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ControlCount - 1 do
    if Controls[i] is TBowlItem then
      TBowlItem(Controls[i]).Selected := (Controls[i] = Sender);
  FSelectedIndex := (Sender as TBowlItem).Tag;
  if Assigned(FOnSelected) then
    FOnSelected(Self);
end;

procedure TBowlListControl.SetSelectedIndex(const Value: Integer);
var
  i: Integer;
begin
  if FSelectedIndex <> Value then
  begin
    FSelectedIndex := Value;
    for i := 0 to ControlCount - 1 do
      if Controls[i] is TBowlItem then
        TBowlItem(Controls[i]).Selected := (TBowlItem(Controls[i]).Tag = FSelectedIndex);
    // NEVOLAT ScrollToSelected ZDE!
  end;
end;

procedure TBowlListControl.ScrollToSelected;
var
  i: Integer;
  BowlItem: TBowlItem;
begin
  for i := 0 to ControlCount - 1 do
    if (Controls[i] is TBowlItem) and (TBowlItem(Controls[i]).Tag = FSelectedIndex) then
    begin
      BowlItem := TBowlItem(Controls[i]);
      // Scroll na zaèátek položky:
      VertScrollBar.Position := BowlItem.Top;
      Break;
    end;
end;

procedure TBowlListControl.ScrollToSelectedDelayed;
begin
  Update;
  PostMessage(Handle, WM_USER + 123, 0, 0);
end;

procedure TBowlListControl.WMDoDelayedScroll(var Msg: TMessage);
begin
  ScrollToSelected;
end;

procedure Register;
begin
  RegisterComponents('Samples', [TBowlListControl]);
end;

end.
