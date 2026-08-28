unit fCampaignEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomCampaignDetail,
  frmCampaignEdit;

type
  TfCampaignEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fCampaignEdit: TfCampaignEdit;

implementation

uses
  uSvcCampaign,
  dmCampaign,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
