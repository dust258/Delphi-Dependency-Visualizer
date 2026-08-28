unit uDomCustomerDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomCustomer;

type
  TDomCustomerDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomCustomerDetail }

constructor TDomCustomerDetail.Create;
begin
  inherited Create;
end;

destructor TDomCustomerDetail.Destroy;
begin
  inherited Destroy;
end;

end.
