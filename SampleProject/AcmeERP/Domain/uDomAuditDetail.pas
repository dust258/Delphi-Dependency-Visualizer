unit uDomAuditDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomAudit;

type
  TDomAuditDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomAuditDetail }

constructor TDomAuditDetail.Create;
begin
  inherited Create;
end;

destructor TDomAuditDetail.Destroy;
begin
  inherited Destroy;
end;

end.
