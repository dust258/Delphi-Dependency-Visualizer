unit uSvcReminder;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomReminder,
  uDomReminderDetail;

type
  TSvcReminder = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbReminderRepo,
  uKernelLog,
  uKernelEvents,
  uSvcDocument;

{ TSvcReminder }

constructor TSvcReminder.Create;
begin
  inherited Create;
end;

destructor TSvcReminder.Destroy;
begin
  inherited Destroy;
end;

end.
