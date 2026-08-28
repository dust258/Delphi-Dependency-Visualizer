unit frmReminderEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomReminderDetail;

type
  TfrmReminderEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmReminderEdit: TfrmReminderEdit;

implementation

uses
  dmReminder,
  uKernelUtils;

{$R *.dfm}

end.
