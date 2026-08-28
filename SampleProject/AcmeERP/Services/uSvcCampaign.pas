unit uSvcCampaign;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomCampaign,
  uDomCampaignDetail;

type
  TSvcCampaign = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbCampaignRepo,
  uKernelLog,
  uKernelEvents,
  uSvcPricing;

{ TSvcCampaign }

constructor TSvcCampaign.Create;
begin
  inherited Create;
end;

destructor TSvcCampaign.Destroy;
begin
  inherited Destroy;
end;

end.
