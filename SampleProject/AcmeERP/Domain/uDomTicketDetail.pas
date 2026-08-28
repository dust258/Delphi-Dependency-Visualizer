unit uDomTicketDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomTicket;

type
  TDomTicketDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomTicketDetail }

constructor TDomTicketDetail.Create;
begin
  inherited Create;
end;

destructor TDomTicketDetail.Destroy;
begin
  inherited Destroy;
end;

end.
