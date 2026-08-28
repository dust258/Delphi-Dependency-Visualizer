unit fDashboardEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDashboardDetail,
  frmDashboardEdit;

type
  TfDashboardEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDashboardEdit: TfDashboardEdit;

implementation

uses
  uSvcDashboard,
  dmDashboard,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
