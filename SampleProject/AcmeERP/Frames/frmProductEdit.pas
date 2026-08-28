unit frmProductEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomProductDetail;

type
  TfrmProductEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmProductEdit: TfrmProductEdit;

implementation

uses
  dmProduct,
  uKernelUtils;

{$R *.dfm}

end.
