unit fCurrencyReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfCurrencyReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fCurrencyReport: TfCurrencyReport;

implementation

uses
  dmCurrency,
  uSvcCurrency,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
