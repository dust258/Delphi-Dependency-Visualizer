unit uDomDepartmentDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomDepartment;

type
  TDomDepartmentDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomDepartmentDetail }

constructor TDomDepartmentDetail.Create;
begin
  inherited Create;
end;

destructor TDomDepartmentDetail.Destroy;
begin
  inherited Destroy;
end;

end.
