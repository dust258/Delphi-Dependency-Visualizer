unit uDomReminderDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomReminder;

type
  TDomReminderDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomReminderDetail }

constructor TDomReminderDetail.Create;
begin
  inherited Create;
end;

destructor TDomReminderDetail.Destroy;
begin
  inherited Destroy;
end;

end.
