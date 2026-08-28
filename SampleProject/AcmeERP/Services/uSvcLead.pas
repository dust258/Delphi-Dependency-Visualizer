unit uSvcLead;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomLead,
  uDomLeadDetail;

type
  TSvcLead = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbLeadRepo,
  uKernelLog,
  uKernelEvents,
  uSvcOpportunity;

{ TSvcLead }

constructor TSvcLead.Create;
begin
  inherited Create;
end;

destructor TSvcLead.Destroy;
begin
  inherited Destroy;
end;

end.
