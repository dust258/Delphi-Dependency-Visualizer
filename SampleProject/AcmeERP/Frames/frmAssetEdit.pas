unit frmAssetEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomAssetDetail;

type
  TfrmAssetEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAssetEdit: TfrmAssetEdit;

implementation

uses
  dmAsset,
  uKernelUtils;

{$R *.dfm}

end.
