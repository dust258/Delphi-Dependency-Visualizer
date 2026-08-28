unit uSvcNotification;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomNotification,
  uDomNotificationDetail;

type
  TSvcNotification = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbNotificationRepo,
  uKernelLog,
  uKernelEvents,
  uSvcPermission;

{ TSvcNotification }

constructor TSvcNotification.Create;
begin
  inherited Create;
end;

destructor TSvcNotification.Destroy;
begin
  inherited Destroy;
end;

end.
