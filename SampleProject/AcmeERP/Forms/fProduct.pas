unit fProduct;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmProductList;

type
  TfProduct = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fProduct: TfProduct;

implementation

uses
  fProductEdit,
  fProductReport,
  dmProduct,
  uSvcProduct,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
