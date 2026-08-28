unit uDbTimesheetRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomTimesheet;

type
  TDbTimesheetRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbTaskRepo;

{ TDbTimesheetRepo }

constructor TDbTimesheetRepo.Create;
begin
  inherited Create;
end;

destructor TDbTimesheetRepo.Destroy;
begin
  inherited Destroy;
end;

end.
