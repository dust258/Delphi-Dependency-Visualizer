unit fQuotationEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomQuotationDetail,
  frmQuotationEdit;

type
  TfQuotationEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fQuotationEdit: TfQuotationEdit;

implementation

uses
  uSvcQuotation,
  dmQuotation,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
