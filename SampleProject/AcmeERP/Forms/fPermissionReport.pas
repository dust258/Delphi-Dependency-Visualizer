unit fPermissionReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfPermissionReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPermissionReport: TfPermissionReport;

implementation

uses
  dmPermission,
  uSvcPermission,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
