unit dmExport;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmExport = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmExport: TdmExport;

implementation

uses
  uSvcExport,
  uDbExportRepo,
  uKernelLog;

{$R *.dfm}

end.
