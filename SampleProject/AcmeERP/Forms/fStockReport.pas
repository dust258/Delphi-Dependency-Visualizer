unit fStockReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfStockReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fStockReport: TfStockReport;

implementation

uses
  dmStock,
  uSvcStock,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
