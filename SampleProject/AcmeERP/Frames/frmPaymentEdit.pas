unit frmPaymentEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomPaymentDetail;

type
  TfrmPaymentEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPaymentEdit: TfrmPaymentEdit;

implementation

uses
  dmPayment,
  uKernelUtils;

{$R *.dfm}

end.
