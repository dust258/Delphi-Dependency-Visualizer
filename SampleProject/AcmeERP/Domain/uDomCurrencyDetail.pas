unit uDomCurrencyDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomCurrency;

type
  TDomCurrencyDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomCurrencyDetail }

constructor TDomCurrencyDetail.Create;
begin
  inherited Create;
end;

destructor TDomCurrencyDetail.Destroy;
begin
  inherited Destroy;
end;

end.
