unit fAudit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmAuditList;

type
  TfAudit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fAudit: TfAudit;

implementation

uses
  fAuditEdit,
  fAuditReport,
  dmAudit,
  uSvcAudit,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
