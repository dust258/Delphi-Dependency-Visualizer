unit uSvcProject;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomProject,
  uDomProjectDetail;

type
  TSvcProject = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbProjectRepo,
  uKernelLog,
  uKernelEvents,
  uSvcTicket;

{ TSvcProject }

constructor TSvcProject.Create;
begin
  inherited Create;
end;

destructor TSvcProject.Destroy;
begin
  inherited Destroy;
end;

end.
