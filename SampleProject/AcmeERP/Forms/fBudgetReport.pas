unit fBudgetReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfBudgetReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fBudgetReport: TfBudgetReport;

implementation

uses
  dmBudget,
  uSvcBudget,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
