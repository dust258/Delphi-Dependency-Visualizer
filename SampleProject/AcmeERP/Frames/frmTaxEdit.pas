unit frmTaxEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTaxDetail;

type
  TfrmTaxEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmTaxEdit: TfrmTaxEdit;

implementation

uses
  dmTax,
  uKernelUtils;

{$R *.dfm}

end.
