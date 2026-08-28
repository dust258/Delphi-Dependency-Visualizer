unit frmCurrencyEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomCurrencyDetail;

type
  TfrmCurrencyEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCurrencyEdit: TfrmCurrencyEdit;

implementation

uses
  dmCurrency,
  uKernelUtils;

{$R *.dfm}

end.
