unit uDomShipment;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomShipment = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomInvoice;

{ TDomShipment }

constructor TDomShipment.Create;
begin
  inherited Create;
end;

destructor TDomShipment.Destroy;
begin
  inherited Destroy;
end;

end.
