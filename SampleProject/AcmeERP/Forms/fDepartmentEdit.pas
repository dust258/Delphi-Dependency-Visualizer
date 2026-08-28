unit fDepartmentEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDepartmentDetail,
  frmDepartmentEdit;

type
  TfDepartmentEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDepartmentEdit: TfDepartmentEdit;

implementation

uses
  uSvcDepartment,
  dmDepartment,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
