unit frmAccountList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomAccount;

type
  TfrmAccountList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAccountList: TfrmAccountList;

implementation

uses
  dmAccount,
  uSvcAccount,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
