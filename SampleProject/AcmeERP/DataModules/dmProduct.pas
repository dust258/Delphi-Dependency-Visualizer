unit dmProduct;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmProduct = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmProduct: TdmProduct;

implementation

uses
  uSvcProduct,
  uDbProductRepo,
  uKernelLog;

{$R *.dfm}

end.
