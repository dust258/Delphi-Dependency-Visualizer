unit fProductEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomProductDetail,
  frmProductEdit;

type
  TfProductEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fProductEdit: TfProductEdit;

implementation

uses
  uSvcProduct,
  dmProduct,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
