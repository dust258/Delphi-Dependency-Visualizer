unit dmInventory;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmInventory = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmInventory: TdmInventory;

implementation

uses
  uSvcInventory,
  uDbInventoryRepo,
  uKernelLog;

{$R *.dfm}

end.
