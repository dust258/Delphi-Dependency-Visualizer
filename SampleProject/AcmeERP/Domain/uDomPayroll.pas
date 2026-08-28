unit uDomPayroll;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomPayroll = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomDepreciation;

{ TDomPayroll }

constructor TDomPayroll.Create;
begin
  inherited Create;
end;

destructor TDomPayroll.Destroy;
begin
  inherited Destroy;
end;

end.
