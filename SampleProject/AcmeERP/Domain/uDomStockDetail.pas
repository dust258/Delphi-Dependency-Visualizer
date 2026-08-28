unit uDomStockDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomStock;

type
  TDomStockDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomStockDetail }

constructor TDomStockDetail.Create;
begin
  inherited Create;
end;

destructor TDomStockDetail.Destroy;
begin
  inherited Destroy;
end;

end.
