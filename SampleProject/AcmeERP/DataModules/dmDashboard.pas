unit dmDashboard;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmDashboard = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmDashboard: TdmDashboard;

implementation

uses
  uSvcDashboard,
  uDbDashboardRepo,
  uKernelLog;

{$R *.dfm}

end.
