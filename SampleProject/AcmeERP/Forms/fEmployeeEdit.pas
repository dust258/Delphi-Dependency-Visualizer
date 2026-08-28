unit fEmployeeEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomEmployeeDetail,
  frmEmployeeEdit;

type
  TfEmployeeEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fEmployeeEdit: TfEmployeeEdit;

implementation

uses
  uSvcEmployee,
  dmEmployee,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
