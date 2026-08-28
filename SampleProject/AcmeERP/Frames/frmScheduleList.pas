unit frmScheduleList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomSchedule;

type
  TfrmScheduleList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmScheduleList: TfrmScheduleList;

implementation

uses
  dmSchedule,
  uSvcSchedule,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
