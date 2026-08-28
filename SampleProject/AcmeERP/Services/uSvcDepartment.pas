unit uSvcDepartment;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomDepartment,
  uDomDepartmentDetail;

type
  TSvcDepartment = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbDepartmentRepo,
  uKernelLog,
  uKernelEvents,
  uSvcRole;

{ TSvcDepartment }

constructor TSvcDepartment.Create;
begin
  inherited Create;
end;

destructor TSvcDepartment.Destroy;
begin
  inherited Destroy;
end;

end.
