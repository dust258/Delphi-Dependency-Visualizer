unit frmSupplierEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomSupplierDetail;

type
  TfrmSupplierEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmSupplierEdit: TfrmSupplierEdit;

implementation

uses
  dmSupplier,
  uKernelUtils;

{$R *.dfm}

end.
