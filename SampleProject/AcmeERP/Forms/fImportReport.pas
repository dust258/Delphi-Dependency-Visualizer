unit fImportReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfImportReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fImportReport: TfImportReport;

implementation

uses
  dmImport,
  uSvcImport,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
