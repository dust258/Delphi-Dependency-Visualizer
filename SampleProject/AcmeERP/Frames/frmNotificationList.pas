unit frmNotificationList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomNotification;

type
  TfrmNotificationList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmNotificationList: TfrmNotificationList;

implementation

uses
  dmNotification,
  uSvcNotification,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
