unit fTicketEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTicketDetail,
  frmTicketEdit;

type
  TfTicketEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fTicketEdit: TfTicketEdit;

implementation

uses
  uSvcTicket,
  dmTicket,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
