unit uDomOpportunity;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomOpportunity = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomContact;

{ TDomOpportunity }

constructor TDomOpportunity.Create;
begin
  inherited Create;
end;

destructor TDomOpportunity.Destroy;
begin
  inherited Destroy;
end;

end.
