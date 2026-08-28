unit uDomLedger;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomLedger = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomJournal;

{ TDomLedger }

constructor TDomLedger.Create;
begin
  inherited Create;
end;

destructor TDomLedger.Destroy;
begin
  inherited Destroy;
end;

end.
