unit fPayment;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmPaymentList;

type
  TfPayment = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPayment: TfPayment;

implementation

uses
  fPaymentEdit,
  fPaymentReport,
  dmPayment,
  uSvcPayment,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
