unit uDomPermission;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomPermission = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomPermission }

constructor TDomPermission.Create;
begin
  inherited Create;
end;

destructor TDomPermission.Destroy;
begin
  inherited Destroy;
end;

end.
