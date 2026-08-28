unit dmQuotation;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmQuotation = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmQuotation: TdmQuotation;

implementation

uses
  uSvcQuotation,
  uDbQuotationRepo,
  uKernelLog;

{$R *.dfm}

end.
