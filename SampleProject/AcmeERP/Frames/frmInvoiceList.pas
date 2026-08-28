unit frmInvoiceList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomInvoice;

type
  TfrmInvoiceList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmInvoiceList: TfrmInvoiceList;

implementation

uses
  dmInvoice,
  uSvcInvoice,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
