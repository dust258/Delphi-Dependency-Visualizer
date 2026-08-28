unit frmQuotationList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomQuotation;

type
  TfrmQuotationList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmQuotationList: TfrmQuotationList;

implementation

uses
  dmQuotation,
  uSvcQuotation,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
