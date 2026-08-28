unit fScheduleReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfScheduleReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fScheduleReport: TfScheduleReport;

implementation

uses
  dmSchedule,
  uSvcSchedule,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
