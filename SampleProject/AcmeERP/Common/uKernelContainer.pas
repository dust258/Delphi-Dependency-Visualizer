unit uKernelContainer;

interface

uses
  System.SysUtils,
  System.Classes,
  uKernelExceptions;

type
  TKernelContainer = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelLog,
  uKernelConfig;

{ TKernelContainer }

constructor TKernelContainer.Create;
begin
  inherited Create;
end;

destructor TKernelContainer.Destroy;
begin
  inherited Destroy;
end;

end.
