unit uDomTax;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomTax = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomDiscount;

{ TDomTax }

constructor TDomTax.Create;
begin
  inherited Create;
end;

destructor TDomTax.Destroy;
begin
  inherited Destroy;
end;

end.
