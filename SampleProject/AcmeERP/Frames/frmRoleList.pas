unit frmRoleList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomRole;

type
  TfrmRoleList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmRoleList: TfrmRoleList;

implementation

uses
  dmRole,
  uSvcRole,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
