unit uDbEmployeeRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomEmployee;

type
  TDbEmployeeRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbPayrollRepo;

{ TDbEmployeeRepo }

constructor TDbEmployeeRepo.Create;
begin
  inherited Create;
end;

destructor TDbEmployeeRepo.Destroy;
begin
  inherited Destroy;
end;

end.
