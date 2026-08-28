unit fPaymentReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfPaymentReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPaymentReport: TfPaymentReport;

implementation

uses
  dmPayment,
  uSvcPayment,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
