unit uDbDepartmentRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomDepartment;

type
  TDbDepartmentRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbRoleRepo;

{ TDbDepartmentRepo }

constructor TDbDepartmentRepo.Create;
begin
  inherited Create;
end;

destructor TDbDepartmentRepo.Destroy;
begin
  inherited Destroy;
end;

end.
