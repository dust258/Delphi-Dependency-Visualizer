unit fJournalEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomJournalDetail,
  frmJournalEdit;

type
  TfJournalEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fJournalEdit: TfJournalEdit;

implementation

uses
  uSvcJournal,
  dmJournal,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
