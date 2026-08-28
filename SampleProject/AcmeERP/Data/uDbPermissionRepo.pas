unit uDbPermissionRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomPermission;

type
  TDbPermissionRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbNotificationRepo;

{ TDbPermissionRepo }

constructor TDbPermissionRepo.Create;
begin
  inherited Create;
end;

destructor TDbPermissionRepo.Destroy;
begin
  inherited Destroy;
end;

end.
