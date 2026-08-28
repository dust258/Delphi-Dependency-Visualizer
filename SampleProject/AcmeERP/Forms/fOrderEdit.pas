unit fOrderEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomOrderDetail,
  frmOrderEdit;

type
  TfOrderEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fOrderEdit: TfOrderEdit;

implementation

uses
  uSvcOrder,
  dmOrder,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
