unit fRoleEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomRoleDetail,
  frmRoleEdit;

type
  TfRoleEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fRoleEdit: TfRoleEdit;

implementation

uses
  uSvcRole,
  dmRole,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
