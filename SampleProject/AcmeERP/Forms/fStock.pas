unit fStock;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmStockList;

type
  TfStock = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fStock: TfStock;

implementation

uses
  fStockEdit,
  fStockReport,
  dmStock,
  uSvcStock,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
