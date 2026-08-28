unit uDomJournal;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomJournal = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomLedger;

{ TDomJournal }

constructor TDomJournal.Create;
begin
  inherited Create;
end;

destructor TDomJournal.Destroy;
begin
  inherited Destroy;
end;

end.
