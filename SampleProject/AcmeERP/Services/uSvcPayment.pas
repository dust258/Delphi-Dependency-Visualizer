unit uSvcPayment;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomPayment,
  uDomPaymentDetail;

type
  TSvcPayment = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbPaymentRepo,
  uKernelLog,
  uKernelEvents,
  uSvcShipment;

{ TSvcPayment }

constructor TSvcPayment.Create;
begin
  inherited Create;
end;

destructor TSvcPayment.Destroy;
begin
  inherited Destroy;
end;

end.
