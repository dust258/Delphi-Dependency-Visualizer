unit dmCampaign;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmCampaign = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmCampaign: TdmCampaign;

implementation

uses
  uSvcCampaign,
  uDbCampaignRepo,
  uKernelLog;

{$R *.dfm}

end.
