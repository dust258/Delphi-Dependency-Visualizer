unit dmAccount;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmAccount = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmAccount: TdmAccount;

implementation

uses
  uSvcAccount,
  uDbAccountRepo,
  uKernelLog;

{$R *.dfm}

end.
