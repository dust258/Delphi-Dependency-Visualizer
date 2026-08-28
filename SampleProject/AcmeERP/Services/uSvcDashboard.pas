unit uSvcDashboard;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomDashboard,
  uDomDashboardDetail;

type
  TSvcDashboard = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbDashboardRepo,
  uKernelLog,
  uKernelEvents,
  uSvcReport;

{ TSvcDashboard }

constructor TSvcDashboard.Create;
begin
  inherited Create;
end;

destructor TSvcDashboard.Destroy;
begin
  inherited Destroy;
end;

end.
