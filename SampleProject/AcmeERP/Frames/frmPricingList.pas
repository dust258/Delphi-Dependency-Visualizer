unit frmPricingList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomPricing;

type
  TfrmPricingList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPricingList: TfrmPricingList;

implementation

uses
  dmPricing,
  uSvcPricing,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
