unit uDomCampaignDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomCampaign;

type
  TDomCampaignDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomCampaignDetail }

constructor TDomCampaignDetail.Create;
begin
  inherited Create;
end;

destructor TDomCampaignDetail.Destroy;
begin
  inherited Destroy;
end;

end.
