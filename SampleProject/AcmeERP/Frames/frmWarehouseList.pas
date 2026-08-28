unit frmWarehouseList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomWarehouse;

type
  TfrmWarehouseList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmWarehouseList: TfrmWarehouseList;

implementation

uses
  dmWarehouse,
  uSvcWarehouse,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
