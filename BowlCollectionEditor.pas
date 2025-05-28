unit BowlCollectionEditor;

interface

uses
  DesignEditors, DesignIntf, BowlTypesDesign;

type
  TBowlCollectionEditor = class(TCollectionEditor)
  protected
    function GetItemCaption(Item: TCollectionItem): string; override;
    function CanEdit(Item: TCollectionItem): Boolean; override;
    function HasSubItems(Item: TCollectionItem): Boolean; override;
    procedure EditSubItems(Item: TCollectionItem); override;
  end;

procedure Register;

implementation

uses
  BowlListControl, BowlTypesDesign, Vcl.Forms, Vcl.Dialogs;

{ TBowlCollectionEditor }

function TBowlCollectionEditor.GetItemCaption(Item: TCollectionItem): string;
begin
  if Item is TDesignBowl then
    Result := TDesignBowl(Item).Name
  else if Item is TDesignBowlProduct then
    Result := TDesignBowlProduct(Item).Name
  else
    Result := inherited GetItemCaption(Item);
end;

function TBowlCollectionEditor.CanEdit(Item: TCollectionItem): Boolean;
begin
  Result := True;
end;

function TBowlCollectionEditor.HasSubItems(Item: TCollectionItem): Boolean;
begin
  Result := Item is TDesignBowl;
end;

procedure TBowlCollectionEditor.EditSubItems(Item: TCollectionItem);
begin
  // Otevøe editor pro kolekci produktù v miskách
  if Item is TDesignBowl then
    ShowCollectionEditorClass(Designer, TDesignBowlProducts, TDesignBowl(Item).Products,
      Format('Products of %s', [TDesignBowl(Item).Name]));
end;

procedure Register;
begin
  RegisterCollectionEditor(TDesignBowls, TBowlCollectionEditor);
end;

end.
