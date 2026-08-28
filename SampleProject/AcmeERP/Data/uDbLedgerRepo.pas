unit uDbLedgerRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomLedger;

type
  TDbLedgerRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbJournalRepo;

{ TDbLedgerRepo }

constructor TDbLedgerRepo.Create;
begin
  inherited Create;
end;

destructor TDbLedgerRepo.Destroy;
begin
  inherited Destroy;
end;

end.
