unit frmDashboardEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDashboardDetail;

type
  TfrmDashboardEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmDashboardEdit: TfrmDashboardEdit;

implementation

uses
  dmDashboard,
  uKernelUtils;

{$R *.dfm}

end.
