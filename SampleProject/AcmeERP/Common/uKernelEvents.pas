unit uKernelEvents;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TKernelEvents = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelLog;

{ TKernelEvents }

constructor TKernelEvents.Create;
begin
  inherited Create;
end;

destructor TKernelEvents.Destroy;
begin
  inherited Destroy;
end;

end.
