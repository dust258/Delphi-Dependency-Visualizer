unit frmWarehouseEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomWarehouseDetail;

type
  TfrmWarehouseEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmWarehouseEdit: TfrmWarehouseEdit;

implementation

uses
  dmWarehouse,
  uKernelUtils;

{$R *.dfm}

end.
