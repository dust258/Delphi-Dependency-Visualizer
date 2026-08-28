unit frmStockList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomStock;

type
  TfrmStockList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmStockList: TfrmStockList;

implementation

uses
  dmStock,
  uSvcStock,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
