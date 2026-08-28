unit fAuditEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomAuditDetail,
  frmAuditEdit;

type
  TfAuditEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fAuditEdit: TfAuditEdit;

implementation

uses
  uSvcAudit,
  dmAudit,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
