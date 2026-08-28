unit uDomPaymentDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomPayment;

type
  TDomPaymentDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomPaymentDetail }

constructor TDomPaymentDetail.Create;
begin
  inherited Create;
end;

destructor TDomPaymentDetail.Destroy;
begin
  inherited Destroy;
end;

end.
