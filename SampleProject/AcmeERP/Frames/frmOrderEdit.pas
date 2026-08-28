unit frmOrderEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomOrderDetail;

type
  TfrmOrderEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmOrderEdit: TfrmOrderEdit;

implementation

uses
  dmOrder,
  uKernelUtils;

{$R *.dfm}

end.
