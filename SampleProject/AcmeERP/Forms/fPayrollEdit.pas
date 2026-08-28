unit fPayrollEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomPayrollDetail,
  frmPayrollEdit;

type
  TfPayrollEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPayrollEdit: TfPayrollEdit;

implementation

uses
  uSvcPayroll,
  dmPayroll,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
