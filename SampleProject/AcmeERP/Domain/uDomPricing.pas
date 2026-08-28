unit uDomPricing;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomPricing = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomCampaign;

{ TDomPricing }

constructor TDomPricing.Create;
begin
  inherited Create;
end;

destructor TDomPricing.Destroy;
begin
  inherited Destroy;
end;

end.
