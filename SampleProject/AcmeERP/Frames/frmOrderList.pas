unit frmOrderList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomOrder;

type
  TfrmOrderList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmOrderList: TfrmOrderList;

implementation

uses
  dmOrder,
  uSvcOrder,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
