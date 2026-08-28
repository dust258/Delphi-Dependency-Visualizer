unit uDbExpenseRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomExpense;

type
  TDbExpenseRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbBudgetRepo;

{ TDbExpenseRepo }

constructor TDbExpenseRepo.Create;
begin
  inherited Create;
end;

destructor TDbExpenseRepo.Destroy;
begin
  inherited Destroy;
end;

end.
