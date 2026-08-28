unit uSvcOrder;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomOrder,
  uDomOrderDetail;

type
  TSvcOrder = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbOrderRepo,
  uKernelLog,
  uKernelEvents,
  uSvcCustomer;

{ TSvcOrder }

constructor TSvcOrder.Create;
begin
  inherited Create;
end;

destructor TSvcOrder.Destroy;
begin
  inherited Destroy;
end;

end.
