unit uDomCampaign;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomCampaign = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomPricing;

{ TDomCampaign }

constructor TDomCampaign.Create;
begin
  inherited Create;
end;

destructor TDomCampaign.Destroy;
begin
  inherited Destroy;
end;

end.
