unit uSvcPricing;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomPricing,
  uDomPricingDetail;

type
  TSvcPricing = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbPricingRepo,
  uKernelLog,
  uKernelEvents,
  uSvcCampaign;

{ TSvcPricing }

constructor TSvcPricing.Create;
begin
  inherited Create;
end;

destructor TSvcPricing.Destroy;
begin
  inherited Destroy;
end;

end.
