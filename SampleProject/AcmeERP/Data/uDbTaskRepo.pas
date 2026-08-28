unit uDbTaskRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomTask;

type
  TDbTaskRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbTimesheetRepo;

{ TDbTaskRepo }

constructor TDbTaskRepo.Create;
begin
  inherited Create;
end;

destructor TDbTaskRepo.Destroy;
begin
  inherited Destroy;
end;

end.
