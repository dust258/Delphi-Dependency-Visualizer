unit dmPayroll;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmPayroll = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmPayroll: TdmPayroll;

implementation

uses
  uSvcPayroll,
  uDbPayrollRepo,
  uKernelLog;

{$R *.dfm}

end.
