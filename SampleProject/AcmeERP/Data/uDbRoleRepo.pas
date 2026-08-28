unit uDbRoleRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomRole;

type
  TDbRoleRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbDepartmentRepo;

{ TDbRoleRepo }

constructor TDbRoleRepo.Create;
begin
  inherited Create;
end;

destructor TDbRoleRepo.Destroy;
begin
  inherited Destroy;
end;

end.
