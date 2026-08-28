unit frmJournalEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomJournalDetail;

type
  TfrmJournalEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmJournalEdit: TfrmJournalEdit;

implementation

uses
  dmJournal,
  uKernelUtils;

{$R *.dfm}

end.
