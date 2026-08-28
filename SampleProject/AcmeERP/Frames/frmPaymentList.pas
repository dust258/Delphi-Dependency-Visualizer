unit frmPaymentList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomPayment;

type
  TfrmPaymentList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPaymentList: TfrmPaymentList;

implementation

uses
  dmPayment,
  uSvcPayment,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
