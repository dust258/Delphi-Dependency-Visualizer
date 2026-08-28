unit fQuotationReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfQuotationReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fQuotationReport: TfQuotationReport;

implementation

uses
  dmQuotation,
  uSvcQuotation,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
