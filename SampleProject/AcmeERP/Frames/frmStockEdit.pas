unit frmStockEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomStockDetail;

type
  TfrmStockEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmStockEdit: TfrmStockEdit;

implementation

uses
  dmStock,
  uKernelUtils;

{$R *.dfm}

end.
