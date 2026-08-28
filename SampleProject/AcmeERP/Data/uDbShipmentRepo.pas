unit uDbShipmentRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomShipment;

type
  TDbShipmentRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbPaymentRepo;

{ TDbShipmentRepo }

constructor TDbShipmentRepo.Create;
begin
  inherited Create;
end;

destructor TDbShipmentRepo.Destroy;
begin
  inherited Destroy;
end;

end.
