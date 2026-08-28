unit uDomAudit;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomAudit = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomSetting;

{ TDomAudit }

constructor TDomAudit.Create;
begin
  inherited Create;
end;

destructor TDomAudit.Destroy;
begin
  inherited Destroy;
end;

end.
