unit uDbBatchRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomBatch;

type
  TDbBatchRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbScheduleRepo;

{ TDbBatchRepo }

constructor TDbBatchRepo.Create;
begin
  inherited Create;
end;

destructor TDbBatchRepo.Destroy;
begin
  inherited Destroy;
end;

end.
