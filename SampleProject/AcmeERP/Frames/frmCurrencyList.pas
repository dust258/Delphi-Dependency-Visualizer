unit frmCurrencyList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomCurrency;

type
  TfrmCurrencyList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCurrencyList: TfrmCurrencyList;

implementation

uses
  dmCurrency,
  uSvcCurrency,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
