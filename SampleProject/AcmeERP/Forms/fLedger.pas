unit fLedger;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmLedgerList;

type
  TfLedger = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fLedger: TfLedger;

implementation

uses
  fLedgerEdit,
  fLedgerReport,
  dmLedger,
  uSvcLedger,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
