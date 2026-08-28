unit uDomOrder;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomOrder = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomCustomer;

{ TDomOrder }

constructor TDomOrder.Create;
begin
  inherited Create;
end;

destructor TDomOrder.Destroy;
begin
  inherited Destroy;
end;

end.
