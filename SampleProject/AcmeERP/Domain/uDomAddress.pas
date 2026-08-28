unit uDomAddress;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomAddress = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomAddress }

constructor TDomAddress.Create;
begin
  inherited Create;
end;

destructor TDomAddress.Destroy;
begin
  inherited Destroy;
end;

end.
