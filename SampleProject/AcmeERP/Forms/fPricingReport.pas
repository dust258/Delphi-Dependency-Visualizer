unit fPricingReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfPricingReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPricingReport: TfPricingReport;

implementation

uses
  dmPricing,
  uSvcPricing,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
