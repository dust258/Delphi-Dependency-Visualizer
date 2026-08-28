unit dmTimesheet;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmTimesheet = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmTimesheet: TdmTimesheet;

implementation

uses
  uSvcTimesheet,
  uDbTimesheetRepo,
  uKernelLog;

{$R *.dfm}

end.
