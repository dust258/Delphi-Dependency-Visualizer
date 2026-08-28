unit dmExpense;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmExpense = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmExpense: TdmExpense;

implementation

uses
  uSvcExpense,
  uDbExpenseRepo,
  uKernelLog;

{$R *.dfm}

end.
