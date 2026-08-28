unit fRefund;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmRefundList;

type
  TfRefund = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fRefund: TfRefund;

implementation

uses
  fRefundEdit,
  fRefundReport,
  dmRefund,
  uSvcRefund,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
