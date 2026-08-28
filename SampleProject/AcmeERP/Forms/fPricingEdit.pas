unit fPricingEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomPricingDetail,
  frmPricingEdit;

type
  TfPricingEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPricingEdit: TfPricingEdit;

implementation

uses
  uSvcPricing,
  dmPricing,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
