unit fWarehouseEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomWarehouseDetail,
  frmWarehouseEdit;

type
  TfWarehouseEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fWarehouseEdit: TfWarehouseEdit;

implementation

uses
  uSvcWarehouse,
  dmWarehouse,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
