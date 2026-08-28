unit uDomUser;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomUser = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomUser }

constructor TDomUser.Create;
begin
  inherited Create;
end;

destructor TDomUser.Destroy;
begin
  inherited Destroy;
end;

end.
