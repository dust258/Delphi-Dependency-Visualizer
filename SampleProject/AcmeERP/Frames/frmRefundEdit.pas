unit frmRefundEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomRefundDetail;

type
  TfrmRefundEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmRefundEdit: TfrmRefundEdit;

implementation

uses
  dmRefund,
  uKernelUtils;

{$R *.dfm}

end.
