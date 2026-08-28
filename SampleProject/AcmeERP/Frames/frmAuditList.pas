unit frmAuditList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomAudit;

type
  TfrmAuditList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAuditList: TfrmAuditList;

implementation

uses
  dmAudit,
  uSvcAudit,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
