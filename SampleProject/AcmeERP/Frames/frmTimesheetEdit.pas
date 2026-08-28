unit frmTimesheetEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTimesheetDetail;

type
  TfrmTimesheetEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmTimesheetEdit: TfrmTimesheetEdit;

implementation

uses
  dmTimesheet,
  uKernelUtils;

{$R *.dfm}

end.
