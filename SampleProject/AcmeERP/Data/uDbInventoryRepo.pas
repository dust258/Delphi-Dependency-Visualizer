unit uDbInventoryRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomInventory;

type
  TDbInventoryRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbStockRepo;

{ TDbInventoryRepo }

constructor TDbInventoryRepo.Create;
begin
  inherited Create;
end;

destructor TDbInventoryRepo.Destroy;
begin
  inherited Destroy;
end;

end.
