unit fDocument;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmDocumentList;

type
  TfDocument = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDocument: TfDocument;

implementation

uses
  fDocumentEdit,
  fDocumentReport,
  dmDocument,
  uSvcDocument,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
