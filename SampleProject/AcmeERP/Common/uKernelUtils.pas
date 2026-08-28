unit uKernelUtils;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TKernelUtils = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelConfig,
  uKernelExceptions;

{ TKernelUtils }

constructor TKernelUtils.Create;
begin
  inherited Create;
end;

destructor TKernelUtils.Destroy;
begin
  inherited Destroy;
end;

end.
