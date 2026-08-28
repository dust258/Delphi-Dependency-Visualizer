unit dmPayment;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmPayment = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmPayment: TdmPayment;

implementation

uses
  uSvcPayment,
  uDbPaymentRepo,
  uKernelLog;

{$R *.dfm}

end.
