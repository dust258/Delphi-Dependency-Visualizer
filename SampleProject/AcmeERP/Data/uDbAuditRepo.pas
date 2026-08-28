unit uDbAuditRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomAudit;

type
  TDbAuditRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbSettingRepo;

{ TDbAuditRepo }

constructor TDbAuditRepo.Create;
begin
  inherited Create;
end;

destructor TDbAuditRepo.Destroy;
begin
  inherited Destroy;
end;

end.
