unit dmInvoice;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmInvoice = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmInvoice: TdmInvoice;

implementation

uses
  uSvcInvoice,
  uDbInvoiceRepo,
  uKernelLog;

{$R *.dfm}

end.
