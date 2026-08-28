unit fNotification;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmNotificationList;

type
  TfNotification = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fNotification: TfNotification;

implementation

uses
  fNotificationEdit,
  fNotificationReport,
  dmNotification,
  uSvcNotification,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
