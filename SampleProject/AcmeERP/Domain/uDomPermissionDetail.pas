unit uDomPermissionDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomPermission;

type
  TDomPermissionDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomPermissionDetail }

constructor TDomPermissionDetail.Create;
begin
  inherited Create;
end;

destructor TDomPermissionDetail.Destroy;
begin
  inherited Destroy;
end;

end.
