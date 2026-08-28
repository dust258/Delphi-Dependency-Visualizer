unit uDbPayrollRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomPayroll;

type
  TDbPayrollRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbEmployeeRepo;

{ TDbPayrollRepo }

constructor TDbPayrollRepo.Create;
begin
  inherited Create;
end;

destructor TDbPayrollRepo.Destroy;
begin
  inherited Destroy;
end;

end.
