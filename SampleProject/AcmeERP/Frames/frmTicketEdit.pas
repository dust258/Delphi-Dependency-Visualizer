unit frmTicketEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTicketDetail;

type
  TfrmTicketEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmTicketEdit: TfrmTicketEdit;

implementation

uses
  dmTicket,
  uKernelUtils;

{$R *.dfm}

end.
