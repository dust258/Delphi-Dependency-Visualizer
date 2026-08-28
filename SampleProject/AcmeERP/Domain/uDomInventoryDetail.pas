unit uDomInventoryDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomInventory;

type
  TDomInventoryDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomInventoryDetail }

constructor TDomInventoryDetail.Create;
begin
  inherited Create;
end;

destructor TDomInventoryDetail.Destroy;
begin
  inherited Destroy;
end;

end.
