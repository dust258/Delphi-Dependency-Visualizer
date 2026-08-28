unit frmPermissionList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomPermission;

type
  TfrmPermissionList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPermissionList: TfrmPermissionList;

implementation

uses
  dmPermission,
  uSvcPermission,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
