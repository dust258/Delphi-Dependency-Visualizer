unit dmMain;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmMain = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmMain: TdmMain;

implementation

uses
  uSvcAuth,
  uKernelLog,
  uKernelConfig,
  uKernelContainer;

{$R *.dfm}

end.
