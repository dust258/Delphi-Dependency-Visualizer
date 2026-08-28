unit fStockEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomStockDetail,
  frmStockEdit;

type
  TfStockEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fStockEdit: TfStockEdit;

implementation

uses
  uSvcStock,
  dmStock,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
