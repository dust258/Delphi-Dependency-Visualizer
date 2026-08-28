unit fSupplier;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmSupplierList;

type
  TfSupplier = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fSupplier: TfSupplier;

implementation

uses
  fSupplierEdit,
  fSupplierReport,
  dmSupplier,
  uSvcSupplier,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
