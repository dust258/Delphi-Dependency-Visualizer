unit uDbPaymentRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomPayment;

type
  TDbPaymentRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbShipmentRepo;

{ TDbPaymentRepo }

constructor TDbPaymentRepo.Create;
begin
  inherited Create;
end;

destructor TDbPaymentRepo.Destroy;
begin
  inherited Destroy;
end;

end.
