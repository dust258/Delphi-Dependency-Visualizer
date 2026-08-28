unit fSetting;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmSettingList;

type
  TfSetting = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fSetting: TfSetting;

implementation

uses
  fSettingEdit,
  fSettingReport,
  dmSetting,
  uSvcSetting,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
