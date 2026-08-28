unit fPayroll;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmPayrollList;

type
  TfPayroll = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPayroll: TfPayroll;

implementation

uses
  fPayrollEdit,
  fPayrollReport,
  dmPayroll,
  uSvcPayroll,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
