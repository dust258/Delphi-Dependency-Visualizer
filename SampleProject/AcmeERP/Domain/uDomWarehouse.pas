unit uDomWarehouse;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomWarehouse = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomSupplier;

{ TDomWarehouse }

constructor TDomWarehouse.Create;
begin
  inherited Create;
end;

destructor TDomWarehouse.Destroy;
begin
  inherited Destroy;
end;

end.
