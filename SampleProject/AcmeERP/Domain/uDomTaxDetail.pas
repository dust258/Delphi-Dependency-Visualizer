unit uDomTaxDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomTax;

type
  TDomTaxDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomTaxDetail }

constructor TDomTaxDetail.Create;
begin
  inherited Create;
end;

destructor TDomTaxDetail.Destroy;
begin
  inherited Destroy;
end;

end.
