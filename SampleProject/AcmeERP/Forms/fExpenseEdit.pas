unit fExpenseEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomExpenseDetail,
  frmExpenseEdit;

type
  TfExpenseEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fExpenseEdit: TfExpenseEdit;

implementation

uses
  uSvcExpense,
  dmExpense,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
