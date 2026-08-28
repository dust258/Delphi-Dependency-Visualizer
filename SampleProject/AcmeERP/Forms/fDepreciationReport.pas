unit fDepreciationReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfDepreciationReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDepreciationReport: TfDepreciationReport;

implementation

uses
  dmDepreciation,
  uSvcDepreciation,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
