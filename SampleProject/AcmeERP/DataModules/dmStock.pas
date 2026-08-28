unit dmStock;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmStock = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmStock: TdmStock;

implementation

uses
  uSvcStock,
  uDbStockRepo,
  uKernelLog;

{$R *.dfm}

end.
