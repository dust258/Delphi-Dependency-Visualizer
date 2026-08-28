unit fCurrencyEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomCurrencyDetail,
  frmCurrencyEdit;

type
  TfCurrencyEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fCurrencyEdit: TfCurrencyEdit;

implementation

uses
  uSvcCurrency,
  dmCurrency,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
