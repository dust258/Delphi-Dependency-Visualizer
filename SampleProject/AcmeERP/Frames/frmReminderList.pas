unit frmReminderList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomReminder;

type
  TfrmReminderList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmReminderList: TfrmReminderList;

implementation

uses
  dmReminder,
  uSvcReminder,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
