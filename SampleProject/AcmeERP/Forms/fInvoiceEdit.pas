unit fInvoiceEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomInvoiceDetail,
  frmInvoiceEdit;

type
  TfInvoiceEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fInvoiceEdit: TfInvoiceEdit;

implementation

uses
  uSvcInvoice,
  dmInvoice,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
