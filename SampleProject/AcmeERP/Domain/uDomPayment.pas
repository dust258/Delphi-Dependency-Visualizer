unit uDomPayment;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomPayment = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomPayment }

constructor TDomPayment.Create;
begin
  inherited Create;
end;

destructor TDomPayment.Destroy;
begin
  inherited Destroy;
end;

end.
