unit fShipment;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmShipmentList;

type
  TfShipment = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fShipment: TfShipment;

implementation

uses
  fShipmentEdit,
  fShipmentReport,
  dmShipment,
  uSvcShipment,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
