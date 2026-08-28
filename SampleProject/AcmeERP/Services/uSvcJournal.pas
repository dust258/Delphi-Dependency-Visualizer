unit uSvcJournal;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomJournal,
  uDomJournalDetail;

type
  TSvcJournal = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbJournalRepo,
  uKernelLog,
  uKernelEvents,
  uSvcLedger;

{ TSvcJournal }

constructor TSvcJournal.Create;
begin
  inherited Create;
end;

destructor TSvcJournal.Destroy;
begin
  inherited Destroy;
end;

end.
