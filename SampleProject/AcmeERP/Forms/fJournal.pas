unit fJournal;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmJournalList;

type
  TfJournal = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fJournal: TfJournal;

implementation

uses
  fJournalEdit,
  fJournalReport,
  dmJournal,
  uSvcJournal,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
