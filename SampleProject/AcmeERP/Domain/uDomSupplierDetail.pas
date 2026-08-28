unit uDomSupplierDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomSupplier;

type
  TDomSupplierDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomSupplierDetail }

constructor TDomSupplierDetail.Create;
begin
  inherited Create;
end;

destructor TDomSupplierDetail.Destroy;
begin
  inherited Destroy;
end;

end.
