unit uDbScheduleRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomSchedule;

type
  TDbScheduleRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbBatchRepo;

{ TDbScheduleRepo }

constructor TDbScheduleRepo.Create;
begin
  inherited Create;
end;

destructor TDbScheduleRepo.Destroy;
begin
  inherited Destroy;
end;

end.
