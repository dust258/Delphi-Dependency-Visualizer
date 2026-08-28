unit fNotificationReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfNotificationReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fNotificationReport: TfNotificationReport;

implementation

uses
  dmNotification,
  uSvcNotification,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
