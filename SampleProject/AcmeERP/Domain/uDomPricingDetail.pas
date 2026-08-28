unit uDomPricingDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomPricing;

type
  TDomPricingDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomPricingDetail }

constructor TDomPricingDetail.Create;
begin
  inherited Create;
end;

destructor TDomPricingDetail.Destroy;
begin
  inherited Destroy;
end;

end.
