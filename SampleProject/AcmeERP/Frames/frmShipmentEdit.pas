unit frmShipmentEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomShipmentDetail;

type
  TfrmShipmentEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmShipmentEdit: TfrmShipmentEdit;

implementation

uses
  dmShipment,
  uKernelUtils;

{$R *.dfm}

end.
