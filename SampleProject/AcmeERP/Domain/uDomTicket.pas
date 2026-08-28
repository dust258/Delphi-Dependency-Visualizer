unit uDomTicket;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomTicket = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomProject;

{ TDomTicket }

constructor TDomTicket.Create;
begin
  inherited Create;
end;

destructor TDomTicket.Destroy;
begin
  inherited Destroy;
end;

end.
