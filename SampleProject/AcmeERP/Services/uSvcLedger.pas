unit uSvcLedger;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomLedger,
  uDomLedgerDetail;

type
  TSvcLedger = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbLedgerRepo,
  uKernelLog,
  uKernelEvents,
  uSvcJournal;

{ TSvcLedger }

constructor TSvcLedger.Create;
begin
  inherited Create;
end;

destructor TSvcLedger.Destroy;
begin
  inherited Destroy;
end;

end.
