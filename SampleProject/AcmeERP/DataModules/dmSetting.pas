unit dmSetting;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmSetting = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmSetting: TdmSetting;

implementation

uses
  uSvcSetting,
  uDbSettingRepo,
  uKernelLog;

{$R *.dfm}

end.
