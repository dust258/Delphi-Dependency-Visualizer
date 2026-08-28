unit fContactEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomContactDetail,
  frmContactEdit;

type
  TfContactEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fContactEdit: TfContactEdit;

implementation

uses
  uSvcContact,
  dmContact,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
