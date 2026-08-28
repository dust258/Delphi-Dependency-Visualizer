unit uSvcReport;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomReport,
  uDomReportDetail;

type
  TSvcReport = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbReportRepo,
  uKernelLog,
  uKernelEvents,
  uSvcDashboard;

{ TSvcReport }

constructor TSvcReport.Create;
begin
  inherited Create;
end;

destructor TSvcReport.Destroy;
begin
  inherited Destroy;
end;

end.
