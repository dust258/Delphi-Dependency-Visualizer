unit fExpenseReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfExpenseReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fExpenseReport: TfExpenseReport;

implementation

uses
  dmExpense,
  uSvcExpense,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
