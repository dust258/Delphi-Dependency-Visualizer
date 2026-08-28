unit dmPermission;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmPermission = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmPermission: TdmPermission;

implementation

uses
  uSvcPermission,
  uDbPermissionRepo,
  uKernelLog;

{$R *.dfm}

end.
