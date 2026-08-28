unit dmRole;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmRole = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmRole: TdmRole;

implementation

uses
  uSvcRole,
  uDbRoleRepo,
  uKernelLog;

{$R *.dfm}

end.
