unit fPermissionEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomPermissionDetail,
  frmPermissionEdit;

type
  TfPermissionEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPermissionEdit: TfPermissionEdit;

implementation

uses
  uSvcPermission,
  dmPermission,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
