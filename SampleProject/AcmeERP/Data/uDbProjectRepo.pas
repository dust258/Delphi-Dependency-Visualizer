unit uDbProjectRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomProject;

type
  TDbProjectRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbTicketRepo;

{ TDbProjectRepo }

constructor TDbProjectRepo.Create;
begin
  inherited Create;
end;

destructor TDbProjectRepo.Destroy;
begin
  inherited Destroy;
end;

end.
