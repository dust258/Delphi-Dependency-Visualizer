unit fExpense;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmExpenseList;

type
  TfExpense = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fExpense: TfExpense;

implementation

uses
  fExpenseEdit,
  fExpenseReport,
  dmExpense,
  uSvcExpense,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
