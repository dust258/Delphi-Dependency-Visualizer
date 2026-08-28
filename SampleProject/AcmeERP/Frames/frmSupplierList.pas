unit frmSupplierList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomSupplier;

type
  TfrmSupplierList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmSupplierList: TfrmSupplierList;

implementation

uses
  dmSupplier,
  uSvcSupplier,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
