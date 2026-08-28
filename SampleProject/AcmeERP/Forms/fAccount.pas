unit fAccount;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmAccountList;

type
  TfAccount = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fAccount: TfAccount;

implementation

uses
  fAccountEdit,
  fAccountReport,
  dmAccount,
  uSvcAccount,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
