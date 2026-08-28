unit frmNotificationEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomNotificationDetail;

type
  TfrmNotificationEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmNotificationEdit: TfrmNotificationEdit;

implementation

uses
  dmNotification,
  uKernelUtils;

{$R *.dfm}

end.
