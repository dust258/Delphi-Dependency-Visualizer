unit uDbTicketRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomTicket;

type
  TDbTicketRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbProjectRepo;

{ TDbTicketRepo }

constructor TDbTicketRepo.Create;
begin
  inherited Create;
end;

destructor TDbTicketRepo.Destroy;
begin
  inherited Destroy;
end;

end.
