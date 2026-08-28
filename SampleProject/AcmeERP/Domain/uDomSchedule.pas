unit uDomSchedule;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomSchedule = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomSchedule }

constructor TDomSchedule.Create;
begin
  inherited Create;
end;

destructor TDomSchedule.Destroy;
begin
  inherited Destroy;
end;

end.
