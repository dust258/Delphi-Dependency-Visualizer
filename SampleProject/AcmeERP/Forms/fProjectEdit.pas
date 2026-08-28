unit fProjectEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomProjectDetail,
  frmProjectEdit;

type
  TfProjectEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fProjectEdit: TfProjectEdit;

implementation

uses
  uSvcProject,
  dmProject,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
