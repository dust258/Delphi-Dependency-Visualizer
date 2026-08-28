unit fRole;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmRoleList;

type
  TfRole = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fRole: TfRole;

implementation

uses
  fRoleEdit,
  fRoleReport,
  dmRole,
  uSvcRole,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
