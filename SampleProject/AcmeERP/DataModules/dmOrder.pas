unit dmOrder;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmOrder = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmOrder: TdmOrder;

implementation

uses
  uSvcOrder,
  uDbOrderRepo,
  uKernelLog;

{$R *.dfm}

end.
