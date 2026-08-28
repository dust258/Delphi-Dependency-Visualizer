unit uSvcExpense;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomExpense,
  uDomExpenseDetail;

type
  TSvcExpense = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbExpenseRepo,
  uKernelLog,
  uKernelEvents,
  uSvcBudget;

{ TSvcExpense }

constructor TSvcExpense.Create;
begin
  inherited Create;
end;

destructor TSvcExpense.Destroy;
begin
  inherited Destroy;
end;

end.
