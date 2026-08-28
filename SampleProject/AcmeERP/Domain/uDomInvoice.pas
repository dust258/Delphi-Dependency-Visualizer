unit uDomInvoice;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomInvoice = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomShipment;

{ TDomInvoice }

constructor TDomInvoice.Create;
begin
  inherited Create;
end;

destructor TDomInvoice.Destroy;
begin
  inherited Destroy;
end;

end.
