unit fReminder;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmReminderList;

type
  TfReminder = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fReminder: TfReminder;

implementation

uses
  fReminderEdit,
  fReminderReport,
  dmReminder,
  uSvcReminder,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
