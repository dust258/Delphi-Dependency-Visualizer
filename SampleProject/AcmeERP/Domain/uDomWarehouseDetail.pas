unit uDomWarehouseDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomWarehouse;

type
  TDomWarehouseDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomWarehouseDetail }

constructor TDomWarehouseDetail.Create;
begin
  inherited Create;
end;

destructor TDomWarehouseDetail.Destroy;
begin
  inherited Destroy;
end;

end.
