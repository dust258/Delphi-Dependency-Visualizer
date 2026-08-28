unit fPayrollReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfPayrollReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPayrollReport: TfPayrollReport;

implementation

uses
  dmPayroll,
  uSvcPayroll,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
