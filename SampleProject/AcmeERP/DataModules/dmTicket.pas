unit dmTicket;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmTicket = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmTicket: TdmTicket;

implementation

uses
  uSvcTicket,
  uDbTicketRepo,
  uKernelLog;

{$R *.dfm}

end.
