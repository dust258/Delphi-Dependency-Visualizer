unit uSvcSupplier;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomSupplier,
  uDomSupplierDetail;

type
  TSvcSupplier = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbSupplierRepo,
  uKernelLog,
  uKernelEvents,
  uSvcWarehouse;

{ TSvcSupplier }

constructor TSvcSupplier.Create;
begin
  inherited Create;
end;

destructor TSvcSupplier.Destroy;
begin
  inherited Destroy;
end;

end.
