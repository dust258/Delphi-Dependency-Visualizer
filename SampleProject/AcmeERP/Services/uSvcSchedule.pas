unit uSvcSchedule;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomSchedule,
  uDomScheduleDetail;

type
  TSvcSchedule = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbScheduleRepo,
  uKernelLog,
  uKernelEvents,
  uSvcBatch;

{ TSvcSchedule }

constructor TSvcSchedule.Create;
begin
  inherited Create;
end;

destructor TSvcSchedule.Destroy;
begin
  inherited Destroy;
end;

end.
