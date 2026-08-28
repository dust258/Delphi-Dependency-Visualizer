unit frmAuditEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomAuditDetail;

type
  TfrmAuditEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAuditEdit: TfrmAuditEdit;

implementation

uses
  dmAudit,
  uKernelUtils;

{$R *.dfm}

end.
