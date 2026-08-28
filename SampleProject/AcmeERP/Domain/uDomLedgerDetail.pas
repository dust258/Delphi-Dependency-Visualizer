unit uDomLedgerDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomLedger;

type
  TDomLedgerDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomLedgerDetail }

constructor TDomLedgerDetail.Create;
begin
  inherited Create;
end;

destructor TDomLedgerDetail.Destroy;
begin
  inherited Destroy;
end;

end.
