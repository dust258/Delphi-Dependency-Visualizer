unit fContact;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmContactList;

type
  TfContact = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fContact: TfContact;

implementation

uses
  fContactEdit,
  fContactReport,
  dmContact,
  uSvcContact,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
