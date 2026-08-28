unit uDomRefund;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomRefund = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomInventory;

{ TDomRefund }

constructor TDomRefund.Create;
begin
  inherited Create;
end;

destructor TDomRefund.Destroy;
begin
  inherited Destroy;
end;

end.
