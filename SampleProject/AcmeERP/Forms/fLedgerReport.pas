unit fLedgerReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfLedgerReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fLedgerReport: TfLedgerReport;

implementation

uses
  dmLedger,
  uSvcLedger,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
