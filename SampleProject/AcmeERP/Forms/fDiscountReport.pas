unit fDiscountReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfDiscountReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDiscountReport: TfDiscountReport;

implementation

uses
  dmDiscount,
  uSvcDiscount,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
