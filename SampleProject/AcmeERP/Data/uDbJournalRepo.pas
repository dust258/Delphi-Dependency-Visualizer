unit uDbJournalRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomJournal;

type
  TDbJournalRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbLedgerRepo;

{ TDbJournalRepo }

constructor TDbJournalRepo.Create;
begin
  inherited Create;
end;

destructor TDbJournalRepo.Destroy;
begin
  inherited Destroy;
end;

end.
