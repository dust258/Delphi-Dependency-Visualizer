unit uDbOpportunityRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomOpportunity;

type
  TDbOpportunityRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbLeadRepo;

{ TDbOpportunityRepo }

constructor TDbOpportunityRepo.Create;
begin
  inherited Create;
end;

destructor TDbOpportunityRepo.Destroy;
begin
  inherited Destroy;
end;

end.
