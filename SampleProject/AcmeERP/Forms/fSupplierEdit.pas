unit fSupplierEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomSupplierDetail,
  frmSupplierEdit;

type
  TfSupplierEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fSupplierEdit: TfSupplierEdit;

implementation

uses
  uSvcSupplier,
  dmSupplier,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
