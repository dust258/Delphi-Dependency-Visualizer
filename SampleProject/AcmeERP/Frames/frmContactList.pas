unit frmContactList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomContact;

type
  TfrmContactList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmContactList: TfrmContactList;

implementation

uses
  dmContact,
  uSvcContact,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
