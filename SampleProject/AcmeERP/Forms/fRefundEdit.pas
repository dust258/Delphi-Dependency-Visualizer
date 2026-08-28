unit fRefundEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomRefundDetail,
  frmRefundEdit;

type
  TfRefundEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fRefundEdit: TfRefundEdit;

implementation

uses
  uSvcRefund,
  dmRefund,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
