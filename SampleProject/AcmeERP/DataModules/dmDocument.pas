unit dmDocument;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmDocument = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmDocument: TdmDocument;

implementation

uses
  uSvcDocument,
  uDbDocumentRepo,
  uKernelLog;

{$R *.dfm}

end.
