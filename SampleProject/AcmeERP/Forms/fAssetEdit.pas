unit fAssetEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomAssetDetail,
  frmAssetEdit;

type
  TfAssetEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fAssetEdit: TfAssetEdit;

implementation

uses
  uSvcAsset,
  dmAsset,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
