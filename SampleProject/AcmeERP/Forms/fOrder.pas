unit fOrder;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmOrderList;

type
  TfOrder = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fOrder: TfOrder;

implementation

uses
  fOrderEdit,
  fOrderReport,
  dmOrder,
  uSvcOrder,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
