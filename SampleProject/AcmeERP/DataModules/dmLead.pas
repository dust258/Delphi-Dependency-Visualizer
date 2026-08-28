unit dmLead;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmLead = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmLead: TdmLead;

implementation

uses
  uSvcLead,
  uDbLeadRepo,
  uKernelLog;

{$R *.dfm}

end.
