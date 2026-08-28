unit fReturnEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomReturnDetail,
  frmReturnEdit;

type
  TfReturnEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fReturnEdit: TfReturnEdit;

implementation

uses
  uSvcReturn,
  dmReturn,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
