unit uDomNotification;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomNotification = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomReport;

{ TDomNotification }

constructor TDomNotification.Create;
begin
  inherited Create;
end;

destructor TDomNotification.Destroy;
begin
  inherited Destroy;
end;

end.
