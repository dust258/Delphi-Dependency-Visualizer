unit fLedgerEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomLedgerDetail,
  frmLedgerEdit;

type
  TfLedgerEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fLedgerEdit: TfLedgerEdit;

implementation

uses
  uSvcLedger,
  dmLedger,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
