unit frmDocumentEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDocumentDetail;

type
  TfrmDocumentEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmDocumentEdit: TfrmDocumentEdit;

implementation

uses
  dmDocument,
  uKernelUtils;

{$R *.dfm}

end.
