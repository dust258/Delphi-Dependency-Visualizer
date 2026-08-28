unit fTimesheetEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTimesheetDetail,
  frmTimesheetEdit;

type
  TfTimesheetEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fTimesheetEdit: TfTimesheetEdit;

implementation

uses
  uSvcTimesheet,
  dmTimesheet,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
