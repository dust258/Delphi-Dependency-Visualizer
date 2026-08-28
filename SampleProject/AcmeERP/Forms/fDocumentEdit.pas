unit fDocumentEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDocumentDetail,
  frmDocumentEdit;

type
  TfDocumentEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDocumentEdit: TfDocumentEdit;

implementation

uses
  uSvcDocument,
  dmDocument,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
