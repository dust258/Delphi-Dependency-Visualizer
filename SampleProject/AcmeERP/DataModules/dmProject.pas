unit dmProject;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmProject = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmProject: TdmProject;

implementation

uses
  uSvcProject,
  uDbProjectRepo,
  uKernelLog;

{$R *.dfm}

end.
