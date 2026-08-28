unit fBatchReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfBatchReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fBatchReport: TfBatchReport;

implementation

uses
  dmBatch,
  uSvcBatch,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
