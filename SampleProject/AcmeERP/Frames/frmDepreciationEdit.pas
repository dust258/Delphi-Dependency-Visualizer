unit frmDepreciationEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDepreciationDetail;

type
  TfrmDepreciationEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmDepreciationEdit: TfrmDepreciationEdit;

implementation

uses
  dmDepreciation,
  uKernelUtils;

{$R *.dfm}

end.
