unit uSvcRefund;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomRefund,
  uDomRefundDetail;

type
  TSvcRefund = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbRefundRepo,
  uKernelLog,
  uKernelEvents,
  uSvcReturn;

{ TSvcRefund }

constructor TSvcRefund.Create;
begin
  inherited Create;
end;

destructor TSvcRefund.Destroy;
begin
  inherited Destroy;
end;

end.
