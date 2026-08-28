unit uDomOpportunityDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomOpportunity;

type
  TDomOpportunityDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomOpportunityDetail }

constructor TDomOpportunityDetail.Create;
begin
  inherited Create;
end;

destructor TDomOpportunityDetail.Destroy;
begin
  inherited Destroy;
end;

end.
