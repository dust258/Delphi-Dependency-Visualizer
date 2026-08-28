unit uDomReport;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomReport = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomNotification;

{ TDomReport }

constructor TDomReport.Create;
begin
  inherited Create;
end;

destructor TDomReport.Destroy;
begin
  inherited Destroy;
end;

end.
