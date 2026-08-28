unit fPaymentEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomPaymentDetail,
  frmPaymentEdit;

type
  TfPaymentEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPaymentEdit: TfPaymentEdit;

implementation

uses
  uSvcPayment,
  dmPayment,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
