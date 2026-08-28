unit frmExpenseList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomExpense;

type
  TfrmExpenseList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmExpenseList: TfrmExpenseList;

implementation

uses
  dmExpense,
  uSvcExpense,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
