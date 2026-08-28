unit uDomCustomer;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomCustomer = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomOrder;

{ TDomCustomer }

constructor TDomCustomer.Create;
begin
  inherited Create;
end;

destructor TDomCustomer.Destroy;
begin
  inherited Destroy;
end;

end.
