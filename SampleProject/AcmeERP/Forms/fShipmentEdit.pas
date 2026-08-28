unit fShipmentEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomShipmentDetail,
  frmShipmentEdit;

type
  TfShipmentEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fShipmentEdit: TfShipmentEdit;

implementation

uses
  uSvcShipment,
  dmShipment,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
