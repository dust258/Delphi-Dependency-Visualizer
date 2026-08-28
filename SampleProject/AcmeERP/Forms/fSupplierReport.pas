unit fSupplierReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfSupplierReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fSupplierReport: TfSupplierReport;

implementation

uses
  dmSupplier,
  uSvcSupplier,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
