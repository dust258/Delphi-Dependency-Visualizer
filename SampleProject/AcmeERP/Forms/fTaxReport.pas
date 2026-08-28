unit fTaxReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfTaxReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fTaxReport: TfTaxReport;

implementation

uses
  dmTax,
  uSvcTax,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
