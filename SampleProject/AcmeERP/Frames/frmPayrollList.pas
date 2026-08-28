unit frmPayrollList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomPayroll;

type
  TfrmPayrollList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPayrollList: TfrmPayrollList;

implementation

uses
  dmPayroll,
  uSvcPayroll,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
