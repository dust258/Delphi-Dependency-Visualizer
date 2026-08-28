unit fQuotation;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmQuotationList;

type
  TfQuotation = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fQuotation: TfQuotation;

implementation

uses
  fQuotationEdit,
  fQuotationReport,
  dmQuotation,
  uSvcQuotation,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
