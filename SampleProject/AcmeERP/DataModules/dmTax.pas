unit dmTax;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmTax = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmTax: TdmTax;

implementation

uses
  uSvcTax,
  uDbTaxRepo,
  uKernelLog;

{$R *.dfm}

end.
