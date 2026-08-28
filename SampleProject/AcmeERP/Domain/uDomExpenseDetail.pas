unit uDomExpenseDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomExpense;

type
  TDomExpenseDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomExpenseDetail }

constructor TDomExpenseDetail.Create;
begin
  inherited Create;
end;

destructor TDomExpenseDetail.Destroy;
begin
  inherited Destroy;
end;

end.
