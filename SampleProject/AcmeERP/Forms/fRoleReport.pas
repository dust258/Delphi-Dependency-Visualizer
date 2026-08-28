unit fRoleReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfRoleReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fRoleReport: TfRoleReport;

implementation

uses
  dmRole,
  uSvcRole,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
