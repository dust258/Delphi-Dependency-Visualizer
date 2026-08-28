unit fLeadReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfLeadReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fLeadReport: TfLeadReport;

implementation

uses
  dmLead,
  uSvcLead,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
