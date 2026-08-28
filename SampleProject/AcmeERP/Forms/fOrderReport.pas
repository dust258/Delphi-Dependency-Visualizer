unit fOrderReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfOrderReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fOrderReport: TfOrderReport;

implementation

uses
  dmOrder,
  uSvcOrder,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
