unit fRefundReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfRefundReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fRefundReport: TfRefundReport;

implementation

uses
  dmRefund,
  uSvcRefund,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
