unit dmNotification;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmNotification = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmNotification: TdmNotification;

implementation

uses
  uSvcNotification,
  uDbNotificationRepo,
  uKernelLog;

{$R *.dfm}

end.
