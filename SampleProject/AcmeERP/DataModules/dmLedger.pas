unit dmLedger;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmLedger = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmLedger: TdmLedger;

implementation

uses
  uSvcLedger,
  uDbLedgerRepo,
  uKernelLog;

{$R *.dfm}

end.
