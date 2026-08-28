unit frmAccountEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomAccountDetail;

type
  TfrmAccountEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAccountEdit: TfrmAccountEdit;

implementation

uses
  dmAccount,
  uKernelUtils;

{$R *.dfm}

end.
