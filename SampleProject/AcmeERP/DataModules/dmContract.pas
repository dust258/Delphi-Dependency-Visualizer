unit dmContract;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmContract = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmContract: TdmContract;

implementation

uses
  uSvcContract,
  uDbContractRepo,
  uKernelLog;

{$R *.dfm}

end.
