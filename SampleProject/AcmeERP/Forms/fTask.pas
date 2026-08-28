unit fTask;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmTaskList;

type
  TfTask = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fTask: TfTask;

implementation

uses
  fTaskEdit,
  fTaskReport,
  dmTask,
  uSvcTask,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
