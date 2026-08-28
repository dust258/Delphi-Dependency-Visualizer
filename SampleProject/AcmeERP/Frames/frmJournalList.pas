unit frmJournalList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomJournal;

type
  TfrmJournalList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmJournalList: TfrmJournalList;

implementation

uses
  dmJournal,
  uSvcJournal,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
