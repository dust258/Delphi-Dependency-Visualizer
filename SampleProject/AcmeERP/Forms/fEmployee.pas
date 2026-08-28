unit fEmployee;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmEmployeeList;

type
  TfEmployee = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fEmployee: TfEmployee;

implementation

uses
  fEmployeeEdit,
  fEmployeeReport,
  dmEmployee,
  uSvcEmployee,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
