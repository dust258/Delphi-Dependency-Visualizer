unit uDomProduct;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomProduct = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomProduct }

constructor TDomProduct.Create;
begin
  inherited Create;
end;

destructor TDomProduct.Destroy;
begin
  inherited Destroy;
end;

end.
