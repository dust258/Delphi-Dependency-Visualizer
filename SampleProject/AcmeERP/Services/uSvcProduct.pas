unit uSvcProduct;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomProduct,
  uDomProductDetail;

type
  TSvcProduct = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbProductRepo,
  uKernelLog,
  uKernelEvents,
  uSvcInvoice;

{ TSvcProduct }

constructor TSvcProduct.Create;
begin
  inherited Create;
end;

destructor TSvcProduct.Destroy;
begin
  inherited Destroy;
end;

end.
