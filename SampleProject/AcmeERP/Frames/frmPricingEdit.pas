unit frmPricingEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomPricingDetail;

type
  TfrmPricingEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPricingEdit: TfrmPricingEdit;

implementation

uses
  dmPricing,
  uKernelUtils;

{$R *.dfm}

end.
