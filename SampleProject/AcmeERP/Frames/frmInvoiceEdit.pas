unit frmInvoiceEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomInvoiceDetail;

type
  TfrmInvoiceEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmInvoiceEdit: TfrmInvoiceEdit;

implementation

uses
  dmInvoice,
  uKernelUtils;

{$R *.dfm}

end.
