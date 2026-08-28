unit dmPricing;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmPricing = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmPricing: TdmPricing;

implementation

uses
  uSvcPricing,
  uDbPricingRepo,
  uKernelLog;

{$R *.dfm}

end.
