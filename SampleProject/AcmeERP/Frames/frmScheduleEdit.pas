unit frmScheduleEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomScheduleDetail;

type
  TfrmScheduleEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmScheduleEdit: TfrmScheduleEdit;

implementation

uses
  dmSchedule,
  uKernelUtils;

{$R *.dfm}

end.
