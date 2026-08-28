unit fDashboard;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmDashboardList;

type
  TfDashboard = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDashboard: TfDashboard;

implementation

uses
  fDashboardEdit,
  fDashboardReport,
  dmDashboard,
  uSvcDashboard,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
