unit fSchedule;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmScheduleList;

type
  TfSchedule = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fSchedule: TfSchedule;

implementation

uses
  fScheduleEdit,
  fScheduleReport,
  dmSchedule,
  uSvcSchedule,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
