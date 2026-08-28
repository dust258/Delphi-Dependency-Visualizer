unit uSvcTimesheet;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTimesheet,
  uDomTimesheetDetail;

type
  TSvcTimesheet = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbTimesheetRepo,
  uKernelLog,
  uKernelEvents,
  uSvcTask;

{ TSvcTimesheet }

constructor TSvcTimesheet.Create;
begin
  inherited Create;
end;

destructor TSvcTimesheet.Destroy;
begin
  inherited Destroy;
end;

end.
