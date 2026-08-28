unit frmRoleEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomRoleDetail;

type
  TfrmRoleEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmRoleEdit: TfrmRoleEdit;

implementation

uses
  dmRole,
  uKernelUtils;

{$R *.dfm}

end.
