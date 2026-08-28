unit frmSettingEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomSettingDetail;

type
  TfrmSettingEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmSettingEdit: TfrmSettingEdit;

implementation

uses
  dmSetting,
  uKernelUtils;

{$R *.dfm}

end.
