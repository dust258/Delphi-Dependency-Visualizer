unit uDomEmployee;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomEmployee = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomEmployee }

constructor TDomEmployee.Create;
begin
  inherited Create;
end;

destructor TDomEmployee.Destroy;
begin
  inherited Destroy;
end;

end.
