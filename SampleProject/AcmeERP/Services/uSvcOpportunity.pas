unit uSvcOpportunity;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomOpportunity,
  uDomOpportunityDetail;

type
  TSvcOpportunity = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbOpportunityRepo,
  uKernelLog,
  uKernelEvents,
  uSvcLead;

{ TSvcOpportunity }

constructor TSvcOpportunity.Create;
begin
  inherited Create;
end;

destructor TSvcOpportunity.Destroy;
begin
  inherited Destroy;
end;

end.
