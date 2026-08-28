unit uKernelExceptions;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TKernelExceptions = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation


{ TKernelExceptions }

constructor TKernelExceptions.Create;
begin
  inherited Create;
end;

destructor TKernelExceptions.Destroy;
begin
  inherited Destroy;
end;

end.
