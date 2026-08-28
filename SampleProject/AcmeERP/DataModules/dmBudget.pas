unit dmBudget;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmBudget = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmBudget: TdmBudget;

implementation

uses
  uSvcBudget,
  uDbBudgetRepo,
  uKernelLog;

{$R *.dfm}

end.
