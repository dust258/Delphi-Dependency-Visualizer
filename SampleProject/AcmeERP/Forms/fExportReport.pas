unit fExportReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfExportReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fExportReport: TfExportReport;

implementation

uses
  dmExport,
  uSvcExport,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
