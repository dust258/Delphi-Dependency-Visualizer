unit fOpportunityReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfOpportunityReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fOpportunityReport: TfOpportunityReport;

implementation

uses
  dmOpportunity,
  uSvcOpportunity,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
