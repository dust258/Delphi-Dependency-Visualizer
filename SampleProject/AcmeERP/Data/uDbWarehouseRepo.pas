unit uDbWarehouseRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomWarehouse;

type
  TDbWarehouseRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbSupplierRepo;

{ TDbWarehouseRepo }

constructor TDbWarehouseRepo.Create;
begin
  inherited Create;
end;

destructor TDbWarehouseRepo.Destroy;
begin
  inherited Destroy;
end;

end.
