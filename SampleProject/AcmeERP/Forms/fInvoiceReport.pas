unit fInvoiceReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfInvoiceReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fInvoiceReport: TfInvoiceReport;

implementation

uses
  dmInvoice,
  uSvcInvoice,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
