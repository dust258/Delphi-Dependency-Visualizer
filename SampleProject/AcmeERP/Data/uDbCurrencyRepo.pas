unit uDbCurrencyRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomCurrency;

type
  TDbCurrencyRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbTaxRepo;

{ TDbCurrencyRepo }

constructor TDbCurrencyRepo.Create;
begin
  inherited Create;
end;

destructor TDbCurrencyRepo.Destroy;
begin
  inherited Destroy;
end;

end.
