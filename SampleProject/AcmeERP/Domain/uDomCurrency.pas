unit uDomCurrency;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomCurrency = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomCurrency }

constructor TDomCurrency.Create;
begin
  inherited Create;
end;

destructor TDomCurrency.Destroy;
begin
  inherited Destroy;
end;

end.
