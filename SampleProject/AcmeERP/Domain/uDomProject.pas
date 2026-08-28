unit uDomProject;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomProject = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomTicket;

{ TDomProject }

constructor TDomProject.Create;
begin
  inherited Create;
end;

destructor TDomProject.Destroy;
begin
  inherited Destroy;
end;

end.
