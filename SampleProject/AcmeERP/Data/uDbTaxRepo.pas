unit uDbTaxRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomTax;

type
  TDbTaxRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbCurrencyRepo;

{ TDbTaxRepo }

constructor TDbTaxRepo.Create;
begin
  inherited Create;
end;

destructor TDbTaxRepo.Destroy;
begin
  inherited Destroy;
end;

end.
