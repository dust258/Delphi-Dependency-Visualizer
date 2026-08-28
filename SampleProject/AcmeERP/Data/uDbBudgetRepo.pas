unit uDbBudgetRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomBudget;

type
  TDbBudgetRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbExpenseRepo;

{ TDbBudgetRepo }

constructor TDbBudgetRepo.Create;
begin
  inherited Create;
end;

destructor TDbBudgetRepo.Destroy;
begin
  inherited Destroy;
end;

end.
