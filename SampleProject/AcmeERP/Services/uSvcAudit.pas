unit uSvcAudit;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomAudit,
  uDomAuditDetail;

type
  TSvcAudit = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbAuditRepo,
  uKernelLog,
  uKernelEvents,
  uSvcSetting;

{ TSvcAudit }

constructor TSvcAudit.Create;
begin
  inherited Create;
end;

destructor TSvcAudit.Destroy;
begin
  inherited Destroy;
end;

end.
