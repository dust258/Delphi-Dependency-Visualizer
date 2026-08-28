unit fTicket;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmTicketList;

type
  TfTicket = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fTicket: TfTicket;

implementation

uses
  fTicketEdit,
  fTicketReport,
  dmTicket,
  uSvcTicket,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
