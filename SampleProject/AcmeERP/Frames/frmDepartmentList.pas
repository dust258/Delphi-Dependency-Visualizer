unit frmDepartmentList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDepartment;

type
  TfrmDepartmentList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmDepartmentList: TfrmDepartmentList;

implementation

uses
  dmDepartment,
  uSvcDepartment,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
