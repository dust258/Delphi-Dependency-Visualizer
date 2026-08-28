unit dmSupplier;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmSupplier = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmSupplier: TdmSupplier;

implementation

uses
  uSvcSupplier,
  uDbSupplierRepo,
  uKernelLog;

{$R *.dfm}

end.
