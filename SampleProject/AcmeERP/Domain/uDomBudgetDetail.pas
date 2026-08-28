unit uDomBudgetDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomBudget;

type
  TDomBudgetDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomBudgetDetail }

constructor TDomBudgetDetail.Create;
begin
  inherited Create;
end;

destructor TDomBudgetDetail.Destroy;
begin
  inherited Destroy;
end;

end.
