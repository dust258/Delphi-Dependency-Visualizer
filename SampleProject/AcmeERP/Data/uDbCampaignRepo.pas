unit uDbCampaignRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomCampaign;

type
  TDbCampaignRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbPricingRepo;

{ TDbCampaignRepo }

constructor TDbCampaignRepo.Create;
begin
  inherited Create;
end;

destructor TDbCampaignRepo.Destroy;
begin
  inherited Destroy;
end;

end.
