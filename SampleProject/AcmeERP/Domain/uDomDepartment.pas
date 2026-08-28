unit uDomDepartment;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomDepartment = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomRole;

{ TDomDepartment }

constructor TDomDepartment.Create;
begin
  inherited Create;
end;

destructor TDomDepartment.Destroy;
begin
  inherited Destroy;
end;

end.
