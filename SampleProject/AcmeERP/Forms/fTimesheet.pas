unit fTimesheet;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmTimesheetList;

type
  TfTimesheet = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fTimesheet: TfTimesheet;

implementation

uses
  fTimesheetEdit,
  fTimesheetReport,
  dmTimesheet,
  uSvcTimesheet,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
