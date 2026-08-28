unit dmRefund;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmRefund = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmRefund: TdmRefund;

implementation

uses
  uSvcRefund,
  uDbRefundRepo,
  uKernelLog;

{$R *.dfm}

end.
