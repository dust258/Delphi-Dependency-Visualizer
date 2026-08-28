unit fScheduleEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomScheduleDetail,
  frmScheduleEdit;

type
  TfScheduleEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fScheduleEdit: TfScheduleEdit;

implementation

uses
  uSvcSchedule,
  dmSchedule,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
