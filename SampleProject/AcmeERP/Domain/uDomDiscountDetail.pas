unit uDomDiscountDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomDiscount;

type
  TDomDiscountDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomDiscountDetail }

constructor TDomDiscountDetail.Create;
begin
  inherited Create;
end;

destructor TDomDiscountDetail.Destroy;
begin
  inherited Destroy;
end;

end.
