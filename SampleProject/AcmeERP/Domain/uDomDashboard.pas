unit uDomDashboard;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomDashboard = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomDashboard }

constructor TDomDashboard.Create;
begin
  inherited Create;
end;

destructor TDomDashboard.Destroy;
begin
  inherited Destroy;
end;

end.
