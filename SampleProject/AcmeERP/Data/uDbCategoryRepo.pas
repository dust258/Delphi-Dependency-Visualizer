unit uDbCategoryRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomCategory;

type
  TDbCategoryRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbDiscountRepo;

{ TDbCategoryRepo }

constructor TDbCategoryRepo.Create;
begin
  inherited Create;
end;

destructor TDbCategoryRepo.Destroy;
begin
  inherited Destroy;
end;

end.
