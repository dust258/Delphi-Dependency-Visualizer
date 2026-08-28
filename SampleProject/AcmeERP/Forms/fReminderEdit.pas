unit fReminderEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomReminderDetail,
  frmReminderEdit;

type
  TfReminderEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fReminderEdit: TfReminderEdit;

implementation

uses
  uSvcReminder,
  dmReminder,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
