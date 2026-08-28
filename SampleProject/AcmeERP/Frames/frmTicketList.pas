unit frmTicketList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTicket;

type
  TfrmTicketList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmTicketList: TfrmTicketList;

implementation

uses
  dmTicket,
  uSvcTicket,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
