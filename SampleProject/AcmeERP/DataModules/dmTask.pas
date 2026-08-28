unit dmTask;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmTask = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmTask: TdmTask;

implementation

uses
  uSvcTask,
  uDbTaskRepo,
  uKernelLog;

{$R *.dfm}

end.
