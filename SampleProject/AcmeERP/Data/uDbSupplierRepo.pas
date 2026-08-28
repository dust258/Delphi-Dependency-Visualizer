unit uDbSupplierRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomSupplier;

type
  TDbSupplierRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbWarehouseRepo;

{ TDbSupplierRepo }

constructor TDbSupplierRepo.Create;
begin
  inherited Create;
end;

destructor TDbSupplierRepo.Destroy;
begin
  inherited Destroy;
end;

end.
