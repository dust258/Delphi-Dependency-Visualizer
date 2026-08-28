unit uDomInvoiceDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomInvoice;

type
  TDomInvoiceDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomInvoiceDetail }

constructor TDomInvoiceDetail.Create;
begin
  inherited Create;
end;

destructor TDomInvoiceDetail.Destroy;
begin
  inherited Destroy;
end;

end.
