unit dmWarehouse;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmWarehouse = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmWarehouse: TdmWarehouse;

implementation

uses
  uSvcWarehouse,
  uDbWarehouseRepo,
  uKernelLog;

{$R *.dfm}

end.
