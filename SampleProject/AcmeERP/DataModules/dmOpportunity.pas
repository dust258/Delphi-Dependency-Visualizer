unit dmOpportunity;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmOpportunity = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmOpportunity: TdmOpportunity;

implementation

uses
  uSvcOpportunity,
  uDbOpportunityRepo,
  uKernelLog;

{$R *.dfm}

end.
