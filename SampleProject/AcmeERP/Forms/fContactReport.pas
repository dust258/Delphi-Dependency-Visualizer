unit fContactReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfContactReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fContactReport: TfContactReport;

implementation

uses
  dmContact,
  uSvcContact,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
