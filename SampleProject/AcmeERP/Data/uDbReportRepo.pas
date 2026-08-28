unit uDbReportRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomReport;

type
  TDbReportRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbDashboardRepo;

{ TDbReportRepo }

constructor TDbReportRepo.Create;
begin
  inherited Create;
end;

destructor TDbReportRepo.Destroy;
begin
  inherited Destroy;
end;

end.
