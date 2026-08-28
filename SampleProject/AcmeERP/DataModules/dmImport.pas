unit dmImport;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmImport = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmImport: TdmImport;

implementation

uses
  uSvcImport,
  uDbImportRepo,
  uKernelLog;

{$R *.dfm}

end.
