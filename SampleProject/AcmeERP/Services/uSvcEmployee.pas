unit uSvcEmployee;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomEmployee,
  uDomEmployeeDetail;

type
  TSvcEmployee = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbEmployeeRepo,
  uKernelLog,
  uKernelEvents,
  uSvcPayroll;

{ TSvcEmployee }

constructor TSvcEmployee.Create;
begin
  inherited Create;
end;

destructor TSvcEmployee.Destroy;
begin
  inherited Destroy;
end;

end.
