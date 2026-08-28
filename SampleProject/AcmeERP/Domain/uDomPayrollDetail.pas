unit uDomPayrollDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomPayroll;

type
  TDomPayrollDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomPayrollDetail }

constructor TDomPayrollDetail.Create;
begin
  inherited Create;
end;

destructor TDomPayrollDetail.Destroy;
begin
  inherited Destroy;
end;

end.
