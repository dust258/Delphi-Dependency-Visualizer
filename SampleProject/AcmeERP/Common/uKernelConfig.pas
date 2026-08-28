unit uKernelConfig;

interface

uses
  System.SysUtils,
  System.Classes,
  uKernelExceptions;

type
  TKernelConfig = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TKernelConfig }

constructor TKernelConfig.Create;
begin
  inherited Create;
end;

destructor TKernelConfig.Destroy;
begin
  inherited Destroy;
end;

end.
