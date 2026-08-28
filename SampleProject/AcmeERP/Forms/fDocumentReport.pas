unit fDocumentReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfDocumentReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDocumentReport: TfDocumentReport;

implementation

uses
  dmDocument,
  uSvcDocument,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
