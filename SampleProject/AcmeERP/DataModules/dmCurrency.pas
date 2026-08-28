unit dmCurrency;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmCurrency = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmCurrency: TdmCurrency;

implementation

uses
  uSvcCurrency,
  uDbCurrencyRepo,
  uKernelLog;

{$R *.dfm}

end.
