unit uSvcCustomer;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomCustomer,
  uDomCustomerDetail;

type
  TSvcCustomer = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbCustomerRepo,
  uKernelLog,
  uKernelEvents,
  uSvcOrder;

{ TSvcCustomer }

constructor TSvcCustomer.Create;
begin
  inherited Create;
end;

destructor TSvcCustomer.Destroy;
begin
  inherited Destroy;
end;

end.
