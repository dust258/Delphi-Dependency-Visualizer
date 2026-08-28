unit frmTaskList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTask;

type
  TfrmTaskList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmTaskList: TfrmTaskList;

implementation

uses
  dmTask,
  uSvcTask,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
