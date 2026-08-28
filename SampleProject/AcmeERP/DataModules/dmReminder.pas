unit dmReminder;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmReminder = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmReminder: TdmReminder;

implementation

uses
  uSvcReminder,
  uDbReminderRepo,
  uKernelLog;

{$R *.dfm}

end.
