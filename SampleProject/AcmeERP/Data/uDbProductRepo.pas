unit uDbProductRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomProduct;

type
  TDbProductRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbInvoiceRepo;

{ TDbProductRepo }

constructor TDbProductRepo.Create;
begin
  inherited Create;
end;

destructor TDbProductRepo.Destroy;
begin
  inherited Destroy;
end;

end.
