unit fWarehouseReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfWarehouseReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fWarehouseReport: TfWarehouseReport;

implementation

uses
  dmWarehouse,
  uSvcWarehouse,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
