unit fLogin;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomUser;

type
  TfLogin = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fLogin: TfLogin;

implementation

uses
  uSvcAuth,
  dmMain,
  uAppContext,
  uKernelConfig,
  uKernelExceptions;

{$R *.dfm}

end.
