unit uDomInventory;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomInventory = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomRefund;

{ TDomInventory }

constructor TDomInventory.Create;
begin
  inherited Create;
end;

destructor TDomInventory.Destroy;
begin
  inherited Destroy;
end;

end.
