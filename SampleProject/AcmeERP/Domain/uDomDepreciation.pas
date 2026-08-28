unit uDomDepreciation;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomDepreciation = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomPayroll;

{ TDomDepreciation }

constructor TDomDepreciation.Create;
begin
  inherited Create;
end;

destructor TDomDepreciation.Destroy;
begin
  inherited Destroy;
end;

end.
