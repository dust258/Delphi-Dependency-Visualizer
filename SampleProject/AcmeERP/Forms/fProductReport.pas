unit fProductReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfProductReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fProductReport: TfProductReport;

implementation

uses
  dmProduct,
  uSvcProduct,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
