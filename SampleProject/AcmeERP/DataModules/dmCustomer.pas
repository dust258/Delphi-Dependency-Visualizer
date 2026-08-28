unit dmCustomer;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmCustomer = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmCustomer: TdmCustomer;

implementation

uses
  uSvcCustomer,
  uDbCustomerRepo,
  uKernelLog;

{$R *.dfm}

end.
