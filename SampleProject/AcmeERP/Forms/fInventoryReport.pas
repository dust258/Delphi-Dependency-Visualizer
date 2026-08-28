unit fInventoryReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfInventoryReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fInventoryReport: TfInventoryReport;

implementation

uses
  dmInventory,
  uSvcInventory,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
