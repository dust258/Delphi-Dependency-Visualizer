unit uDomTask;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomTask = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomTask }

constructor TDomTask.Create;
begin
  inherited Create;
end;

destructor TDomTask.Destroy;
begin
  inherited Destroy;
end;

end.
