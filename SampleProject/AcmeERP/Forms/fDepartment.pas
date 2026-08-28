unit fDepartment;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmDepartmentList;

type
  TfDepartment = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDepartment: TfDepartment;

implementation

uses
  fDepartmentEdit,
  fDepartmentReport,
  dmDepartment,
  uSvcDepartment,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
