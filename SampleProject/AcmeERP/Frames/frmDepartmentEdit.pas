unit frmDepartmentEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDepartmentDetail;

type
  TfrmDepartmentEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmDepartmentEdit: TfrmDepartmentEdit;

implementation

uses
  dmDepartment,
  uKernelUtils;

{$R *.dfm}

end.
