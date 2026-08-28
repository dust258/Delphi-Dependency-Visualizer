unit frmExpenseEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomExpenseDetail;

type
  TfrmExpenseEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmExpenseEdit: TfrmExpenseEdit;

implementation

uses
  dmExpense,
  uKernelUtils;

{$R *.dfm}

end.
