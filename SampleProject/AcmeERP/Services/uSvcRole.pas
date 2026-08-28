unit uSvcRole;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomRole,
  uDomRoleDetail;

type
  TSvcRole = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbRoleRepo,
  uKernelLog,
  uKernelEvents,
  uSvcDepartment;

{ TSvcRole }

constructor TSvcRole.Create;
begin
  inherited Create;
end;

destructor TSvcRole.Destroy;
begin
  inherited Destroy;
end;

end.
