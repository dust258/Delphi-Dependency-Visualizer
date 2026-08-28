unit fSettingEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomSettingDetail,
  frmSettingEdit;

type
  TfSettingEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fSettingEdit: TfSettingEdit;

implementation

uses
  uSvcSetting,
  dmSetting,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
