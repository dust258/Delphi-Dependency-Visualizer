unit uDomProductDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomProduct;

type
  TDomProductDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomProductDetail }

constructor TDomProductDetail.Create;
begin
  inherited Create;
end;

destructor TDomProductDetail.Destroy;
begin
  inherited Destroy;
end;

end.
