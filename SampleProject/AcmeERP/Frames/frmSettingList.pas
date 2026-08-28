unit frmSettingList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomSetting;

type
  TfrmSettingList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmSettingList: TfrmSettingList;

implementation

uses
  dmSetting,
  uSvcSetting,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
