unit BowlTypesDesign;

interface

uses
  System.Classes;

type
  TDesignBowlProduct = class(TCollectionItem)
  private
    FID: Integer;
    FName: string;
    FBrand: string;
    FAmount: Integer;
  published
    property ID: Integer read FID write FID;
    property Name: string read FName write FName;
    property Brand: string read FBrand write FBrand;
    property Amount: Integer read FAmount write FAmount;
  end;

  TDesignBowlProducts = class(TCollection)
  private
    function GetItem(Index: Integer): TDesignBowlProduct;
    procedure SetItem(Index: Integer; Value: TDesignBowlProduct);
  public
    constructor Create(AOwner: TPersistent);
    property Items[Index: Integer]: TDesignBowlProduct read GetItem write SetItem; default;
  end;

  TDesignBowl = class(TCollectionItem)
  private
    FID: Integer;
    FName: string;
    FProducts: TDesignBowlProducts;
    procedure SetProducts(Value: TDesignBowlProducts);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Products: TDesignBowlProducts read FProducts write SetProducts;
  published
    property ID: Integer read FID write FID;
    property Name: string read FName write FName;
  end;

  TDesignBowls = class(TCollection)
  private
    function GetItem(Index: Integer): TDesignBowl;
    procedure SetItem(Index: Integer; Value: TDesignBowl);
  public
    constructor Create(AOwner: TPersistent);
    property Items[Index: Integer]: TDesignBowl read GetItem write SetItem; default;
  end;

implementation

{ TDesignBowlProducts }

constructor TDesignBowlProducts.Create(AOwner: TPersistent);
begin
  inherited Create(TDesignBowlProduct);
end;

function TDesignBowlProducts.GetItem(Index: Integer): TDesignBowlProduct;
begin
  Result := TDesignBowlProduct(inherited GetItem(Index));
end;

procedure TDesignBowlProducts.SetItem(Index: Integer; Value: TDesignBowlProduct);
begin
  inherited SetItem(Index, Value);
end;

{ TDesignBowl }

constructor TDesignBowl.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FProducts := TDesignBowlProducts.Create(Self);
end;

destructor TDesignBowl.Destroy;
begin
  FProducts.Free;
  inherited;
end;

procedure TDesignBowl.SetProducts(Value: TDesignBowlProducts);
begin
  FProducts.Assign(Value);
end;

{ TDesignBowls }

constructor TDesignBowls.Create(AOwner: TPersistent);
begin
  inherited Create(TDesignBowl);
end;

function TDesignBowls.GetItem(Index: Integer): TDesignBowl;
begin
  Result := TDesignBowl(inherited GetItem(Index));
end;

procedure TDesignBowls.SetItem(Index: Integer; Value: TDesignBowl);
begin
  inherited SetItem(Index, Value);
end;

end.
