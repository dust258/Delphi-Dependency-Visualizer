unit fAsset;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmAssetList;

type
  TfAsset = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fAsset: TfAsset;

implementation

uses
  fAssetEdit,
  fAssetReport,
  dmAsset,
  uSvcAsset,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
