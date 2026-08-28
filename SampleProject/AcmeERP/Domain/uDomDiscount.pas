unit uDomDiscount;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomDiscount = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomTax;

{ TDomDiscount }

constructor TDomDiscount.Create;
begin
  inherited Create;
end;

destructor TDomDiscount.Destroy;
begin
  inherited Destroy;
end;

end.
