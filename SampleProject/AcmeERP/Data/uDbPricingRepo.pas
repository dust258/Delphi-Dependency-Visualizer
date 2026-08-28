unit uDbPricingRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomPricing;

type
  TDbPricingRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbCampaignRepo;

{ TDbPricingRepo }

constructor TDbPricingRepo.Create;
begin
  inherited Create;
end;

destructor TDbPricingRepo.Destroy;
begin
  inherited Destroy;
end;

end.
