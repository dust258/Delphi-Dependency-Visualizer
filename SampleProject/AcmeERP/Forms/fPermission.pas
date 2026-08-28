unit fPermission;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmPermissionList;

type
  TfPermission = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPermission: TfPermission;

implementation

uses
  fPermissionEdit,
  fPermissionReport,
  dmPermission,
  uSvcPermission,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
