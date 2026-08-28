unit frmShipmentList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomShipment;

type
  TfrmShipmentList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmShipmentList: TfrmShipmentList;

implementation

uses
  dmShipment,
  uSvcShipment,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
