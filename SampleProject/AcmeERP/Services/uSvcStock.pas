unit uSvcStock;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomStock,
  uDomStockDetail;

type
  TSvcStock = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbStockRepo,
  uKernelLog,
  uKernelEvents,
  uSvcInventory;

{ TSvcStock }

constructor TSvcStock.Create;
begin
  inherited Create;
end;

destructor TSvcStock.Destroy;
begin
  inherited Destroy;
end;

end.
