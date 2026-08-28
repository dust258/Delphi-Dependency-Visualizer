unit uDbSettingRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomSetting;

type
  TDbSettingRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbAuditRepo;

{ TDbSettingRepo }

constructor TDbSettingRepo.Create;
begin
  inherited Create;
end;

destructor TDbSettingRepo.Destroy;
begin
  inherited Destroy;
end;

end.
