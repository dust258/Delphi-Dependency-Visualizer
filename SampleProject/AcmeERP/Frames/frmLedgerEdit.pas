unit frmLedgerEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomLedgerDetail;

type
  TfrmLedgerEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmLedgerEdit: TfrmLedgerEdit;

implementation

uses
  dmLedger,
  uKernelUtils;

{$R *.dfm}

end.
