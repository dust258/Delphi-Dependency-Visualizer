unit uDbContractRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomContract;

type
  TDbContractRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbQuotationRepo;

{ TDbContractRepo }

constructor TDbContractRepo.Create;
begin
  inherited Create;
end;

destructor TDbContractRepo.Destroy;
begin
  inherited Destroy;
end;

end.
