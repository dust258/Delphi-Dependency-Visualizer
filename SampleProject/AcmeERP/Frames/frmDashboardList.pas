unit frmDashboardList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDashboard;

type
  TfrmDashboardList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmDashboardList: TfrmDashboardList;

implementation

uses
  dmDashboard,
  uSvcDashboard,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
