unit frmTimesheetList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTimesheet;

type
  TfrmTimesheetList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmTimesheetList: TfrmTimesheetList;

implementation

uses
  dmTimesheet,
  uSvcTimesheet,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
