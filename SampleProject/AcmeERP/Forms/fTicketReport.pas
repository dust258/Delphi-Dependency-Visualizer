unit fTicketReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfTicketReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fTicketReport: TfTicketReport;

implementation

uses
  dmTicket,
  uSvcTicket,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
