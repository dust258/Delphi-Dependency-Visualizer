unit frmAssetList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomAsset;

type
  TfrmAssetList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAssetList: TfrmAssetList;

implementation

uses
  dmAsset,
  uSvcAsset,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
