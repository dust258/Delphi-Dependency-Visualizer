unit uSvcTask;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTask,
  uDomTaskDetail;

type
  TSvcTask = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbTaskRepo,
  uKernelLog,
  uKernelEvents,
  uSvcTimesheet;

{ TSvcTask }

constructor TSvcTask.Create;
begin
  inherited Create;
end;

destructor TSvcTask.Destroy;
begin
  inherited Destroy;
end;

end.
