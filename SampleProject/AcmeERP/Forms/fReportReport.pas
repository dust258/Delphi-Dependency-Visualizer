unit fReportReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfReportReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fReportReport: TfReportReport;

implementation

uses
  dmReport,
  uSvcReport,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
