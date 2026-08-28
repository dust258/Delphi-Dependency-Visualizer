unit frmRefundList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomRefund;

type
  TfrmRefundList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmRefundList: TfrmRefundList;

implementation

uses
  dmRefund,
  uSvcRefund,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
