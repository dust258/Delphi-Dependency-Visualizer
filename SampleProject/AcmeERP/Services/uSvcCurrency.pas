unit uSvcCurrency;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomCurrency,
  uDomCurrencyDetail;

type
  TSvcCurrency = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbCurrencyRepo,
  uKernelLog,
  uKernelEvents,
  uSvcTax;

{ TSvcCurrency }

constructor TSvcCurrency.Create;
begin
  inherited Create;
end;

destructor TSvcCurrency.Destroy;
begin
  inherited Destroy;
end;

end.
