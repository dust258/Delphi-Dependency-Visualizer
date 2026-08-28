unit fTimesheetReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfTimesheetReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fTimesheetReport: TfTimesheetReport;

implementation

uses
  dmTimesheet,
  uSvcTimesheet,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
