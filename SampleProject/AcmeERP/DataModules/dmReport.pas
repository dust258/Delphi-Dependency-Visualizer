unit dmReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmReport = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmReport: TdmReport;

implementation

uses
  uSvcReport,
  uDbReportRepo,
  uKernelLog;

{$R *.dfm}

end.
