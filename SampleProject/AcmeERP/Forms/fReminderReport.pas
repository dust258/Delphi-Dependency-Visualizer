unit fReminderReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfReminderReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fReminderReport: TfReminderReport;

implementation

uses
  dmReminder,
  uSvcReminder,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
