unit uSvcInvoice;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomInvoice,
  uDomInvoiceDetail;

type
  TSvcInvoice = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbInvoiceRepo,
  uKernelLog,
  uKernelEvents,
  uSvcProduct;

{ TSvcInvoice }

constructor TSvcInvoice.Create;
begin
  inherited Create;
end;

destructor TSvcInvoice.Destroy;
begin
  inherited Destroy;
end;

end.
