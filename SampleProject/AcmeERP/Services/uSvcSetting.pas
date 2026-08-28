unit uSvcSetting;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomSetting,
  uDomSettingDetail;

type
  TSvcSetting = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbSettingRepo,
  uKernelLog,
  uKernelEvents,
  uSvcAudit;

{ TSvcSetting }

constructor TSvcSetting.Create;
begin
  inherited Create;
end;

destructor TSvcSetting.Destroy;
begin
  inherited Destroy;
end;

end.
