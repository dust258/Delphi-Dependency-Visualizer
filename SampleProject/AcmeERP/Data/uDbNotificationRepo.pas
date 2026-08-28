unit uDbNotificationRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomNotification;

type
  TDbNotificationRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbPermissionRepo;

{ TDbNotificationRepo }

constructor TDbNotificationRepo.Create;
begin
  inherited Create;
end;

destructor TDbNotificationRepo.Destroy;
begin
  inherited Destroy;
end;

end.
