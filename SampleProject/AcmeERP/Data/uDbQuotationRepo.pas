unit uDbQuotationRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomQuotation;

type
  TDbQuotationRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbContractRepo;

{ TDbQuotationRepo }

constructor TDbQuotationRepo.Create;
begin
  inherited Create;
end;

destructor TDbQuotationRepo.Destroy;
begin
  inherited Destroy;
end;

end.
