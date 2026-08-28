unit uSvcPayroll;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomPayroll,
  uDomPayrollDetail;

type
  TSvcPayroll = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbPayrollRepo,
  uKernelLog,
  uKernelEvents,
  uSvcEmployee;

{ TSvcPayroll }

constructor TSvcPayroll.Create;
begin
  inherited Create;
end;

destructor TSvcPayroll.Destroy;
begin
  inherited Destroy;
end;

end.
