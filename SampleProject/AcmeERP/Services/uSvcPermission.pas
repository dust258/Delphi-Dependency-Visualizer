unit uSvcPermission;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomPermission,
  uDomPermissionDetail;

type
  TSvcPermission = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbPermissionRepo,
  uKernelLog,
  uKernelEvents,
  uSvcNotification;

{ TSvcPermission }

constructor TSvcPermission.Create;
begin
  inherited Create;
end;

destructor TSvcPermission.Destroy;
begin
  inherited Destroy;
end;

end.
