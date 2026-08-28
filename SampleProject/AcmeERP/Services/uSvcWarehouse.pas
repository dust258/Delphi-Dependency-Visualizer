unit uSvcWarehouse;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomWarehouse,
  uDomWarehouseDetail;

type
  TSvcWarehouse = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbWarehouseRepo,
  uKernelLog,
  uKernelEvents,
  uSvcSupplier;

{ TSvcWarehouse }

constructor TSvcWarehouse.Create;
begin
  inherited Create;
end;

destructor TSvcWarehouse.Destroy;
begin
  inherited Destroy;
end;

end.
