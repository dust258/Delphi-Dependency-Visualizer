unit frmLedgerList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomLedger;

type
  TfrmLedgerList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmLedgerList: TfrmLedgerList;

implementation

uses
  dmLedger,
  uSvcLedger,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
