unit frmDocumentList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDocument;

type
  TfrmDocumentList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmDocumentList: TfrmDocumentList;

implementation

uses
  dmDocument,
  uSvcDocument,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
