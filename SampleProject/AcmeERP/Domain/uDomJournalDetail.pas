unit uDomJournalDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomJournal;

type
  TDomJournalDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomJournalDetail }

constructor TDomJournalDetail.Create;
begin
  inherited Create;
end;

destructor TDomJournalDetail.Destroy;
begin
  inherited Destroy;
end;

end.
