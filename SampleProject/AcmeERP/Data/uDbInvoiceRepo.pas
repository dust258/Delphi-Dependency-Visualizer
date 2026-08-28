unit uDbInvoiceRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomInvoice;

type
  TDbInvoiceRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbProductRepo;

{ TDbInvoiceRepo }

constructor TDbInvoiceRepo.Create;
begin
  inherited Create;
end;

destructor TDbInvoiceRepo.Destroy;
begin
  inherited Destroy;
end;

end.
