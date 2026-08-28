unit fEmployeeReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfEmployeeReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fEmployeeReport: TfEmployeeReport;

implementation

uses
  dmEmployee,
  uSvcEmployee,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
