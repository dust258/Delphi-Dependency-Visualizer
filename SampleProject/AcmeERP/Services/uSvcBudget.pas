unit uSvcBudget;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomBudget,
  uDomBudgetDetail;

type
  TSvcBudget = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbBudgetRepo,
  uKernelLog,
  uKernelEvents,
  uSvcExpense;

{ TSvcBudget }

constructor TSvcBudget.Create;
begin
  inherited Create;
end;

destructor TSvcBudget.Destroy;
begin
  inherited Destroy;
end;

end.
