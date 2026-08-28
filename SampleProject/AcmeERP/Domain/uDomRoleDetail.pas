unit uDomRoleDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomRole;

type
  TDomRoleDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomRoleDetail }

constructor TDomRoleDetail.Create;
begin
  inherited Create;
end;

destructor TDomRoleDetail.Destroy;
begin
  inherited Destroy;
end;

end.
