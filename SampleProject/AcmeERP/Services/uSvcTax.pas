unit uSvcTax;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTax,
  uDomTaxDetail;

type
  TSvcTax = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbTaxRepo,
  uKernelLog,
  uKernelEvents,
  uSvcCurrency;

{ TSvcTax }

constructor TSvcTax.Create;
begin
  inherited Create;
end;

destructor TSvcTax.Destroy;
begin
  inherited Destroy;
end;

end.
