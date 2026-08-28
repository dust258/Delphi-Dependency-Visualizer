unit dmSchedule;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmSchedule = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmSchedule: TdmSchedule;

implementation

uses
  uSvcSchedule,
  uDbScheduleRepo,
  uKernelLog;

{$R *.dfm}

end.
