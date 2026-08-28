unit frmPermissionEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomPermissionDetail;

type
  TfrmPermissionEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPermissionEdit: TfrmPermissionEdit;

implementation

uses
  dmPermission,
  uKernelUtils;

{$R *.dfm}

end.
