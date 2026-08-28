unit uDomSupplier;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomSupplier = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomWarehouse;

{ TDomSupplier }

constructor TDomSupplier.Create;
begin
  inherited Create;
end;

destructor TDomSupplier.Destroy;
begin
  inherited Destroy;
end;

end.
