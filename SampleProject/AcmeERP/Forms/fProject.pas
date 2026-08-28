unit fProject;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmProjectList;

type
  TfProject = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fProject: TfProject;

implementation

uses
  fProjectEdit,
  fProjectReport,
  dmProject,
  uSvcProject,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
