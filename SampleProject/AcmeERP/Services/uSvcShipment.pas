unit uSvcShipment;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomShipment,
  uDomShipmentDetail;

type
  TSvcShipment = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbShipmentRepo,
  uKernelLog,
  uKernelEvents,
  uSvcPayment;

{ TSvcShipment }

constructor TSvcShipment.Create;
begin
  inherited Create;
end;

destructor TSvcShipment.Destroy;
begin
  inherited Destroy;
end;

end.
