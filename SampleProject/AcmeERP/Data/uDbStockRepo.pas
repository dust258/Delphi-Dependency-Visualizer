unit uDbStockRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomStock;

type
  TDbStockRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbInventoryRepo;

{ TDbStockRepo }

constructor TDbStockRepo.Create;
begin
  inherited Create;
end;

destructor TDbStockRepo.Destroy;
begin
  inherited Destroy;
end;

end.
