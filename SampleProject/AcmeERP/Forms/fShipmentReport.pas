unit fShipmentReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfShipmentReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fShipmentReport: TfShipmentReport;

implementation

uses
  dmShipment,
  uSvcShipment,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
