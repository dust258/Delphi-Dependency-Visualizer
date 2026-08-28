unit fDepartmentReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfDepartmentReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDepartmentReport: TfDepartmentReport;

implementation

uses
  dmDepartment,
  uSvcDepartment,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
