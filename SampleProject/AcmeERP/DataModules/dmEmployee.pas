unit dmEmployee;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmEmployee = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmEmployee: TdmEmployee;

implementation

uses
  uSvcEmployee,
  uDbEmployeeRepo,
  uKernelLog;

{$R *.dfm}

end.
