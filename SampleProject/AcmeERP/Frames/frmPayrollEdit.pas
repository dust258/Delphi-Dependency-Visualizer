unit frmPayrollEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomPayrollDetail;

type
  TfrmPayrollEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPayrollEdit: TfrmPayrollEdit;

implementation

uses
  dmPayroll,
  uKernelUtils;

{$R *.dfm}

end.
