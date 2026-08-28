unit frmQuotationEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomQuotationDetail;

type
  TfrmQuotationEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmQuotationEdit: TfrmQuotationEdit;

implementation

uses
  dmQuotation,
  uKernelUtils;

{$R *.dfm}

end.
