unit fCampaignReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfCampaignReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fCampaignReport: TfCampaignReport;

implementation

uses
  dmCampaign,
  uSvcCampaign,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
