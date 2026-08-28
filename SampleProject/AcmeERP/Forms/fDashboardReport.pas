unit fDashboardReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfDashboardReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDashboardReport: TfDashboardReport;

implementation

uses
  dmDashboard,
  uSvcDashboard,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
