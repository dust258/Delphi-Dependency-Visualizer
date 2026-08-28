unit fJournalReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfJournalReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fJournalReport: TfJournalReport;

implementation

uses
  dmJournal,
  uSvcJournal,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
