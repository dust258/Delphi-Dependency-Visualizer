unit fSettingReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfSettingReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fSettingReport: TfSettingReport;

implementation

uses
  dmSetting,
  uSvcSetting,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
