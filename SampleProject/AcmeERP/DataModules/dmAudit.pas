unit dmAudit;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmAudit = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmAudit: TdmAudit;

implementation

uses
  uSvcAudit,
  uDbAuditRepo,
  uKernelLog;

{$R *.dfm}

end.
