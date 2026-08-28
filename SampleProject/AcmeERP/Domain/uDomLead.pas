unit uDomLead;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomLead = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomLead }

constructor TDomLead.Create;
begin
  inherited Create;
end;

destructor TDomLead.Destroy;
begin
  inherited Destroy;
end;

end.
