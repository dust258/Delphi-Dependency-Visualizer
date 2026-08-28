unit fCampaign;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmCampaignList;

type
  TfCampaign = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fCampaign: TfCampaign;

implementation

uses
  fCampaignEdit,
  fCampaignReport,
  dmCampaign,
  uSvcCampaign,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
