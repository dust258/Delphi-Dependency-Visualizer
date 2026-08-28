unit frmProductList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomProduct;

type
  TfrmProductList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmProductList: TfrmProductList;

implementation

uses
  dmProduct,
  uSvcProduct,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
