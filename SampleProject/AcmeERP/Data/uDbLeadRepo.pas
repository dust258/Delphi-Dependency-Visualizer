unit uDbLeadRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomLead;

type
  TDbLeadRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbOpportunityRepo;

{ TDbLeadRepo }

constructor TDbLeadRepo.Create;
begin
  inherited Create;
end;

destructor TDbLeadRepo.Destroy;
begin
  inherited Destroy;
end;

end.
