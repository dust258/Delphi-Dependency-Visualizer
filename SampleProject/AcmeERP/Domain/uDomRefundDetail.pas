unit uDomRefundDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomRefund;

type
  TDomRefundDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomRefundDetail }

constructor TDomRefundDetail.Create;
begin
  inherited Create;
end;

destructor TDomRefundDetail.Destroy;
begin
  inherited Destroy;
end;

end.
