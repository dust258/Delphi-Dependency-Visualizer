unit fCustomerReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfCustomerReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fCustomerReport: TfCustomerReport;

implementation

uses
  dmCustomer,
  uSvcCustomer,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
