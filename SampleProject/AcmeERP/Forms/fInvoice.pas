unit fInvoice;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmInvoiceList;

type
  TfInvoice = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fInvoice: TfInvoice;

implementation

uses
  fInvoiceEdit,
  fInvoiceReport,
  dmInvoice,
  uSvcInvoice,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
