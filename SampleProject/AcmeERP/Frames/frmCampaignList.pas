unit frmCampaignList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomCampaign;

type
  TfrmCampaignList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCampaignList: TfrmCampaignList;

implementation

uses
  dmCampaign,
  uSvcCampaign,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
