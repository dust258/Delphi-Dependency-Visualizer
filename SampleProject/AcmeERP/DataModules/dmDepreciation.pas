unit dmDepreciation;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmDepreciation = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmDepreciation: TdmDepreciation;

implementation

uses
  uSvcDepreciation,
  uDbDepreciationRepo,
  uKernelLog;

{$R *.dfm}

end.
