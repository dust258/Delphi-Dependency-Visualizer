unit uDomDashboardDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomDashboard;

type
  TDomDashboardDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomDashboardDetail }

constructor TDomDashboardDetail.Create;
begin
  inherited Create;
end;

destructor TDomDashboardDetail.Destroy;
begin
  inherited Destroy;
end;

end.
