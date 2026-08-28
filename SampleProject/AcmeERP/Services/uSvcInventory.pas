unit uSvcInventory;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomInventory,
  uDomInventoryDetail;

type
  TSvcInventory = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbInventoryRepo,
  uKernelLog,
  uKernelEvents,
  uSvcStock;

{ TSvcInventory }

constructor TSvcInventory.Create;
begin
  inherited Create;
end;

destructor TSvcInventory.Destroy;
begin
  inherited Destroy;
end;

end.
