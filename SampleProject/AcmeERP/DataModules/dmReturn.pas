unit dmReturn;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmReturn = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmReturn: TdmReturn;

implementation

uses
  uSvcReturn,
  uDbReturnRepo,
  uKernelLog;

{$R *.dfm}

end.
