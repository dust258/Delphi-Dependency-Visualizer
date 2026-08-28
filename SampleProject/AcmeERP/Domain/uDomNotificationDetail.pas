unit uDomNotificationDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomNotification;

type
  TDomNotificationDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomNotificationDetail }

constructor TDomNotificationDetail.Create;
begin
  inherited Create;
end;

destructor TDomNotificationDetail.Destroy;
begin
  inherited Destroy;
end;

end.
