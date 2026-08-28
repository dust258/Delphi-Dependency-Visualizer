unit fWarehouse;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmWarehouseList;

type
  TfWarehouse = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fWarehouse: TfWarehouse;

implementation

uses
  fWarehouseEdit,
  fWarehouseReport,
  dmWarehouse,
  uSvcWarehouse,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
