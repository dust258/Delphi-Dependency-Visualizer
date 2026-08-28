unit fAccountEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomAccountDetail,
  frmAccountEdit;

type
  TfAccountEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fAccountEdit: TfAccountEdit;

implementation

uses
  uSvcAccount,
  dmAccount,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
