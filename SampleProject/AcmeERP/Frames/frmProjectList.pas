unit frmProjectList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomProject;

type
  TfrmProjectList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmProjectList: TfrmProjectList;

implementation

uses
  dmProject,
  uSvcProject,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
