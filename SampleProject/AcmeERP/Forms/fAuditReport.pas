unit fAuditReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfAuditReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fAuditReport: TfAuditReport;

implementation

uses
  dmAudit,
  uSvcAudit,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
