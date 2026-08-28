unit fTaskEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTaskDetail,
  frmTaskEdit;

type
  TfTaskEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fTaskEdit: TfTaskEdit;

implementation

uses
  uSvcTask,
  dmTask,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
