unit fPricing;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmPricingList;

type
  TfPricing = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPricing: TfPricing;

implementation

uses
  fPricingEdit,
  fPricingReport,
  dmPricing,
  uSvcPricing,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
