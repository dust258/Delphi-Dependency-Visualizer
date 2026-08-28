unit uSvcTicket;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTicket,
  uDomTicketDetail;

type
  TSvcTicket = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbTicketRepo,
  uKernelLog,
  uKernelEvents,
  uSvcProject;

{ TSvcTicket }

constructor TSvcTicket.Create;
begin
  inherited Create;
end;

destructor TSvcTicket.Destroy;
begin
  inherited Destroy;
end;

end.
