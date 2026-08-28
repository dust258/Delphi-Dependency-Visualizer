unit frmReturnEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomReturnDetail;

type
  TfrmReturnEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmReturnEdit: TfrmReturnEdit;

implementation

uses
  dmReturn,
  uKernelUtils;

{$R *.dfm}

end.
