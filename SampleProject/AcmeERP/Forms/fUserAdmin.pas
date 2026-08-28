unit fUserAdmin;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomUser;

type
  TfUserAdmin = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fUserAdmin: TfUserAdmin;

implementation

uses
  dmMain,
  uSvcAuth,
  uDbUserRepo,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
