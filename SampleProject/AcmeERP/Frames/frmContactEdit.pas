unit frmContactEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomContactDetail;

type
  TfrmContactEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmContactEdit: TfrmContactEdit;

implementation

uses
  dmContact,
  uKernelUtils;

{$R *.dfm}

end.
