unit fCurrency;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmCurrencyList;

type
  TfCurrency = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fCurrency: TfCurrency;

implementation

uses
  fCurrencyEdit,
  fCurrencyReport,
  dmCurrency,
  uSvcCurrency,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
