unit fNotificationEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomNotificationDetail,
  frmNotificationEdit;

type
  TfNotificationEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fNotificationEdit: TfNotificationEdit;

implementation

uses
  uSvcNotification,
  dmNotification,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
