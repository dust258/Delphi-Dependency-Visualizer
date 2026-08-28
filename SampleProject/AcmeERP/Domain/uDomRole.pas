unit uDomRole;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomRole = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomDepartment;

{ TDomRole }

constructor TDomRole.Create;
begin
  inherited Create;
end;

destructor TDomRole.Destroy;
begin
  inherited Destroy;
end;

end.
