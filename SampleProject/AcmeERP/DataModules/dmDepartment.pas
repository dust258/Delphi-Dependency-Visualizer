unit dmDepartment;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmDepartment = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmDepartment: TdmDepartment;

implementation

uses
  uSvcDepartment,
  uDbDepartmentRepo,
  uKernelLog;

{$R *.dfm}

end.
