unit fContractReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfContractReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fContractReport: TfContractReport;

implementation

uses
  dmContract,
  uSvcContract,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
