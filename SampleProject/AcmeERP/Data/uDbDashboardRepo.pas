unit uDbDashboardRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomDashboard;

type
  TDbDashboardRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbReportRepo;

{ TDbDashboardRepo }

constructor TDbDashboardRepo.Create;
begin
  inherited Create;
end;

destructor TDbDashboardRepo.Destroy;
begin
  inherited Destroy;
end;

end.
