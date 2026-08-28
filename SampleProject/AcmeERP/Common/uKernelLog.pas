unit uKernelLog;

interface

uses
  System.SysUtils,
  System.Classes,
  uKernelConfig;

type
  TKernelLog = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TKernelLog }

constructor TKernelLog.Create;
begin
  inherited Create;
end;

destructor TKernelLog.Destroy;
begin
  inherited Destroy;
end;

end.
