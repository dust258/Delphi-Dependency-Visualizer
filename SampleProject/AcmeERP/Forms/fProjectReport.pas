unit fProjectReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfProjectReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fProjectReport: TfProjectReport;

implementation

uses
  dmProject,
  uSvcProject,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
