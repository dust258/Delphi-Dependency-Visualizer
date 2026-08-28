unit uDbDiscountRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomDiscount;

type
  TDbDiscountRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbCategoryRepo;

{ TDbDiscountRepo }

constructor TDbDiscountRepo.Create;
begin
  inherited Create;
end;

destructor TDbDiscountRepo.Destroy;
begin
  inherited Destroy;
end;

end.
