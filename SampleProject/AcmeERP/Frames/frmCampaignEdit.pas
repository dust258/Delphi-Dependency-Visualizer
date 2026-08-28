unit frmCampaignEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomCampaignDetail;

type
  TfrmCampaignEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCampaignEdit: TfrmCampaignEdit;

implementation

uses
  dmCampaign,
  uKernelUtils;

{$R *.dfm}

end.
