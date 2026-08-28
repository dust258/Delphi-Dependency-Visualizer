unit dmJournal;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmJournal = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmJournal: TdmJournal;

implementation

uses
  uSvcJournal,
  uDbJournalRepo,
  uKernelLog;

{$R *.dfm}

end.
