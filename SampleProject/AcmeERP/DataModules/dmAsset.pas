unit dmAsset;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmAsset = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmAsset: TdmAsset;

implementation

uses
  uSvcAsset,
  uDbAssetRepo,
  uKernelLog;

{$R *.dfm}

end.
